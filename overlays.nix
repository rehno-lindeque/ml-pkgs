{ flake }:
let
  pythonOverrides = final: prev: let
    inherit (final.pkgs) fetchFromGitHub;

    # override-torchdata = oldAttrs: {
    #   src = fetchFromGitHub {
    #     owner = "pytorch";
    #     repo = "data";
    #     # rev = "v${version}";
    #     rev = "e86cedc5ffd024ea293f541fc77e8a3b4856c8c9"; # git branch release/0.3.0
    #     sha256 = "sha256:0vyfg7z180w8q6k85v241p1d9gnxq8gdkpvhmykyjf5hnr77cc4z";
    #   };

    #   doCheck = false; # torchtext test dependency doesn't currently build
    # };

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
    albumentations = final.callPackage ./pkgs/albumentations {};
    amazon-s3-plugin-for-pytorch = final.callPackage flake.inputs.amazon-s3-plugin-for-pytorch {};
    aravis = final.callPackage ./pkgs/aravis {};
    darkflow = final.callPackage ./pkgs/darkflow {};
    efficientnet-pytorch = final.callPackage ./pkgs/efficientnet-pytorch {};
    einops = (final.callPackage ./pkgs/einops {}).overridePythonAttrs override-einops;
    expecttest = final.callPackage flake.inputs.expecttest {};
    fairseq = (final.callPackage flake.inputs.fairseq {}).overrideAttrs override-fairseq;
    ideepcolor = final.callPackage ./pkgs/ideepcolor {};
    imagenet-utils = final.callPackage ./pkgs/imagenet-utils {};
    keras = final.callPackage ./pkgs/keras {};
    keras-resnet = final.callPackage ./pkgs/keras-resnet {};
    keras-retinanet = final.callPackage ./pkgs/keras-retinanet {};
    kornia = final.callPackage ./pkgs/kornia {};
    labelimg = final.callPackage ./pkgs/labelimg {};
    openpano = final.callPackage ./pkgs/openpano {};
    pretrainedmodels = final.callPackage ./pkgs/pretrainedmodels {};
    # pytorch-bin = final.callPackage ./pkgs/pytorch/bin.nix {};
    pytorch-nightly-bin = final.callPackage ./pkgs/pytorch/nightly-bin.nix { };
    pytorch-unstable = final.callPackage flake.inputs.pytorch-unstable {
      cudaSupport = true;
      # Using the previous pytorch is necessary because pytorch-unstable is defined in terms of pytorch.
      # That is, this avoids a cycle if the next overlay defines pytorch = pytorch-unstable.
      inherit (prev) pytorch;
    };
    qdarkstyle = final.callPackage ./pkgs/qdarkstyle {};
    sacrebleu = final.callPackage flake.inputs.sacrebleu {};
    segmentation-models-pytorch = final.callPackage ./pkgs/segmentation-models-pytorch {};
    tensorflow-tensorboard = final.callPackage flake.inputs.tensorflow-tensorboard {};
    timm = final.callPackage ./pkgs/timm {};
    torchaudio = (final.callPackage flake.inputs.torchaudio {}).overridePythonAttrs override-torchaudio;
    torchaudio-nightly-bin = final.callPackage ./pkgs/torchaudio/nightly-bin.nix { pytorch = final.pytorch-nightly-bin; };
    torchdata-bin = final.callPackage flake.inputs.torchdata-bin { pytorch = final.pytorch-bin; };
    torchdata-nightly-bin = final.callPackage ./pkgs/torchdata/nightly-bin.nix { pytorch = final.pytorch-nightly-bin; };
    torchdata-unstable = (final.callPackage flake.inputs.torchdata-unstable {
      pytorch = final.pytorch-nightly-bin;
      torchaudio = final.torchaudio-nightly-bin;
      torchtext = final.torchtext-nightly-bin;
    }).overridePythonAttrs override-torchdata;
    torchtext = (final.callPackage flake.inputs.torchtext {}).overrideAttrs override-torchtext;
    torchtext-nightly-bin = final.callPackage ./pkgs/torchtext/nightly-bin.nix { pytorch = final.pytorch-nightly-bin; };
    torchvision-nightly-bin = final.callPackage ./pkgs/torchvision/nightly-bin.nix { pytorch = final.pytorch-nightly-bin; };
    wandb = final.callPackage ./pkgs/wandb {};
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
