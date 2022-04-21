let
  # Inputs that cannot be specified in the flake inputs schema (e.g. single file urls)
  additionalInputs = {
    amazon-s3-plugin-for-pytorch = builtins.fetchurl {
      url = https://raw.githubusercontent.com/NixOS/nixpkgs/835b9f2b58277fac67eb96b5ab2d21f2315295e6/pkgs/development/python-modules/amazon-s3-plugin-for-pytorch/default.nix;
      sha256 = "sha256:1v4xs6abb1wlrccb4a8r71l355hg86xhwm8ilc8vly2p15vryxnv";
    };
    pytorch-unstable = builtins.fetchurl {
      url = https://raw.githubusercontent.com/rehno-lindeque/nixpkgs/f43cfcd81387c453ef74da55e098cd076885a2b2/pkgs/development/python-modules/pytorch/unstable.nix;
      sha256 = "sha256:1fi41id5kmlviykqfrjlvm43dnlkd0155zvcr4aw2x756i2f6z5g";
    };
    torchdata-unstable = builtins.fetchurl {
      url = https://raw.githubusercontent.com/rehno-lindeque/nixpkgs/f43cfcd81387c453ef74da55e098cd076885a2b2/pkgs/development/python-modules/torchdata/unstable.nix;
      sha256 = "sha256:02c9nkfsj4aw16i6h2mhi1r7jd1i683qyn7pg1q6gnnhkfhjjkdx";
    };
    expecttest = builtins.fetchurl {
      # https://github.com/NixOS/nixpkgs/pull/160197
      url = https://raw.githubusercontent.com/NixOS/nixpkgs/da2b767621fd538881e130d12ecdfdd3195727a3/pkgs/development/python-modules/expecttest/default.nix;
      sha256 = "sha256:0hvisfpzy20y3cfk2mhsyqazg4xp5aj147nrxs7yrmilbxb68l0b";
    };
    sacrebleu = builtins.fetchurl {
      # https://github.com/NixOS/nixpkgs/pull/160205
      url = https://raw.githubusercontent.com/NixOS/nixpkgs/64ab7ab9debb6d93311083a735419f837d8d6022/pkgs/development/python-modules/sacrebleu/default.nix;
      sha256 = "sha256:1md4fa3xjv1qcy4yqj7gvc5y9zm2zpv6syfb6k0z229xc46589rx";
    };
    fairseq = builtins.fetchurl {
      # https://github.com/NixOS/nixpkgs/pull/160206
      url = https://raw.githubusercontent.com/NixOS/nixpkgs/3b4512affed042a5bab8debdd6a41b0eb7d143da/pkgs/development/python-modules/fairseq/default.nix;
      sha256 = "sha256:0hjiq8qrrw6wckbkk4i4zy9gydn660al28sfd0r65iwsjnl68lfp";
    };
    torchtext = builtins.fetchurl {
      # https://github.com/NixOS/nixpkgs/pull/160207
      url = https://raw.githubusercontent.com/NixOS/nixpkgs/c96132b4a0df81106c91bddca6f895fe5d44469e/pkgs/development/python-modules/torchtext/default.nix;
      sha256 = "sha256:1x1v9xawi0x9grg39vrj7ia6iqf4kv31bchn2qsam856bf9w5dxq";
    };
    torchaudio = builtins.fetchurl {
      # https://github.com/NixOS/nixpkgs/pull/160210
      url = https://raw.githubusercontent.com/NixOS/nixpkgs/ffe409095cfcec679fe0f0a97db6adb4c0c6d32d/pkgs/development/python-modules/torchaudio/default.nix;
      sha256 = "sha256:1i5h5rsx8r1wf4a7m1di0mf7kpsjqwlc8ndi0iayc8mlkd7hrz3v";
    };
    tensorflow-tensorboard = builtins.fetchurl {
      # ...
      url = https://raw.githubusercontent.com/rehno-lindeque/nixpkgs/e6997a4c433c117563443952e5de5cd4265d0065/pkgs/development/python-modules/tensorflow-tensorboard/default.nix;
      sha256 = "sha256:1117mrchn1d06308ycjd9ww0zwy5z5pylmw2midsgzkxnpisvkb7";
    };
  };

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
  in {
    albumentations = final.callPackage ./pkgs/albumentations {};
    amazon-s3-plugin-for-pytorch = final.callPackage additionalInputs.amazon-s3-plugin-for-pytorch {};
    aravis = final.callPackage ./pkgs/aravis {};
    darkflow = final.callPackage ./pkgs/darkflow {};
    efficientnet-pytorch = final.callPackage ./pkgs/efficientnet-pytorch {};
    einops = (final.callPackage ./pkgs/einops {}).overridePythonAttrs override-einops;
    expecttest = final.callPackage additionalInputs.expecttest {};
    fairseq = (final.callPackage additionalInputs.fairseq {}).overrideAttrs override-fairseq;
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
    pytorch-unstable = final.callPackage additionalInputs.pytorch-unstable {
      cudaSupport = true;
      # Using the previous pytorch is necessary because pytorch-unstable is defined in terms of pytorch.
      # That is, this avoids a cycle if the next overlay defines pytorch = pytorch-unstable.
      inherit (prev) pytorch;
    };
    torchdata-unstable = final.callPackage additionalInputs.torchdata-unstable {
      # pytorch = final.pytorch-unstable; # TODO
    };
    qdarkstyle = final.callPackage ./pkgs/qdarkstyle {};
    sacrebleu = final.callPackage additionalInputs.sacrebleu {};
    segmentation-models-pytorch = final.callPackage ./pkgs/segmentation-models-pytorch {};
    tensorflow-tensorboard = final.callPackage additionalInputs.tensorflow-tensorboard {};
    timm = final.callPackage ./pkgs/timm {};
    torchaudio = (final.callPackage additionalInputs.torchaudio {}).overridePythonAttrs override-torchaudio;
    # torchdata = (final.callPackage additionalInputs.torchdata { torchaudio = final.torchaudio-bin; }).overridePythonAttrs override-torchdata;
    torchtext = (final.callPackage additionalInputs.torchtext {}).overrideAttrs override-torchtext;
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
