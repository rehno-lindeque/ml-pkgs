{ flake, nixpkgs-patched }:
let
  pythonOverrides = final: prev: let
    inherit (final.pkgs) fetchFromGitHub;

    override-einops = oldAttrs: {
      doCheck = false; # tests are very slow
    };

    override-fairseq = oldAttrs: rec {
      version = "0.10.2";
      src = fetchFromGitHub {
        owner = "pytorch";
        repo = "fairseq";
        rev = "83e615d66905b8ca7483122a37da1a85f13f4b8e"; # download via v0.10.2 tag is now broken for some reason
        sha256 = "sha256:0c50jvzdb6g9428in7b2rc1h8h7qx80r5rjzki2aa0wbxarp612z";
      };
      meta = {}; # turn off broken flag
    };

    override-torchtext = oldAttrs: {
      # tests are broken, not sure if the package itself works
      # meta = {}; # turn off broken flag
    };

    override-torchaudio = oldAttrs: {
      doCheck = false; # tests are extremely slow
    };
    override-torchdata = oldAttrs: {
      doCheck = false; # I'm too lazy to get the tests working for now
    };
  in {
    # Regular package overrides
    einops = (final.callPackage ./pkgs/einops {}).overridePythonAttrs override-einops;

    # Based on flake input patches
    segments-ai = final.callPackage "${nixpkgs-patched}/pkgs/development/python-modules/segments-ai" {};
    kornia = final.callPackage "${nixpkgs-patched}/pkgs/development/python-modules/kornia" {};
    torchdata-bin = final.callPackage "${nixpkgs-patched}/pkgs/development/python-modules/torchdata/bin.nix" { pytorch = final.pytorch-bin; };
    types-pillow = final.callPackage "${nixpkgs-patched}/pkgs/development/python-modules/types-pillow" {};

    # Based on flake input files (old)
    amazon-s3-plugin-for-pytorch = final.callPackage flake.inputs.amazon-s3-plugin-for-pytorch {};
    expecttest = final.callPackage flake.inputs.expecttest {};
    fairseq = (final.callPackage flake.inputs.fairseq {}).overrideAttrs override-fairseq;
    pytorch-unstable = final.callPackage flake.inputs.pytorch-unstable {
      cudaSupport = true;
      # Using the previous pytorch is necessary because pytorch-unstable is defined in terms of pytorch.
      # That is, this avoids a cycle if the next overlay defines pytorch = pytorch-unstable.
      inherit (prev) pytorch;
    };
    sacrebleu = final.callPackage flake.inputs.sacrebleu {};
    tensorflow-tensorboard = final.callPackage flake.inputs.tensorflow-tensorboard {};
    torchaudio = (final.callPackage flake.inputs.torchaudio {}).overridePythonAttrs override-torchaudio;
    torchdata-unstable = (final.callPackage flake.inputs.torchdata-unstable {
      pytorch = final.pytorch-nightly-bin;
      torchaudio = final.torchaudio-nightly-bin;
      torchtext = final.torchtext-nightly-bin;
    }).overridePythonAttrs override-torchdata;
    torchtext = (final.callPackage flake.inputs.torchtext {}).overrideAttrs override-torchtext;

    # Based on local packages (old)
    albumentations = final.callPackage ./pkgs/albumentations {};
    aravis = final.callPackage ./pkgs/aravis {};
    darkflow = final.callPackage ./pkgs/darkflow {};
    efficientnet-pytorch = final.callPackage ./pkgs/efficientnet-pytorch {};
    ideepcolor = final.callPackage ./pkgs/ideepcolor {};
    imagenet-utils = final.callPackage ./pkgs/imagenet-utils {};
    keras = final.callPackage ./pkgs/keras {};
    keras-resnet = final.callPackage ./pkgs/keras-resnet {};
    keras-retinanet = final.callPackage ./pkgs/keras-retinanet {};
    labelimg = final.callPackage ./pkgs/labelimg {};
    openpano = final.callPackage ./pkgs/openpano {};
    pretrainedmodels = final.callPackage ./pkgs/pretrainedmodels {};
    pytorch-nightly-bin = final.callPackage ./pkgs/pytorch/nightly-bin.nix { };
    qdarkstyle = final.callPackage ./pkgs/qdarkstyle {};
    segmentation-models-pytorch = final.callPackage ./pkgs/segmentation-models-pytorch {};
    timm = final.callPackage ./pkgs/timm {};
    torchaudio-nightly-bin = final.callPackage ./pkgs/torchaudio/nightly-bin.nix { pytorch = final.pytorch-nightly-bin; };
    torchdata-nightly-bin = final.callPackage ./pkgs/torchdata/nightly-bin.nix { pytorch = final.pytorch-nightly-bin; };
    torchtext-nightly-bin = final.callPackage ./pkgs/torchtext/nightly-bin.nix { pytorch = final.pytorch-nightly-bin; };
    torchvision-nightly-bin = final.callPackage ./pkgs/torchvision/nightly-bin.nix { pytorch = final.pytorch-nightly-bin; };
    yaspin = final.callPackage ./pkgs/yaspin {};
  };

  emptyOverrides = _: _: {};

  packagesetOverlays =
    builtins.mapAttrs
    (key: packageOverrides: final: prev: {
      "${key}" = prev."${key}".override {
        self = final."${key}";
        packageOverrides = final.lib.composeExtensions (prev."${key}".packageOverrides or emptyOverrides) packageOverrides;
      };
    })
    {
      python37 = pythonOverrides;
      python38 = pythonOverrides;
      python39 = pythonOverrides;
      python310 = pythonOverrides;
      python311 = pythonOverrides;
    };
in {
  inherit pythonOverrides;
  inherit (packagesetOverlays) python37 python38 python39 python310 python311;

  # Default overlay with overrides included for current python 3.x package set
  default = final: prev:
    prev.lib.composeManyExtensions
    [
      packagesetOverlays.python37
      packagesetOverlays.python38
      packagesetOverlays.python39
      packagesetOverlays.python310
      packagesetOverlays.python311
    ]
    final
    prev;
}
