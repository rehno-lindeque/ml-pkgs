let
  # Inputs that cannot be specified in the flake inputs schema (e.g. single file urls)
  additionalInputs = {
    amazon-s3-plugin-for-pytorch = builtins.fetchurl {
      url = https://raw.githubusercontent.com/NixOS/nixpkgs/835b9f2b58277fac67eb96b5ab2d21f2315295e6/pkgs/development/python-modules/amazon-s3-plugin-for-pytorch/default.nix;
      sha256 = "sha256:1v4xs6abb1wlrccb4a8r71l355hg86xhwm8ilc8vly2p15vryxnv";
    };
  };

  pythonOverrides = final: prev: {
    albumentations = final.callPackage ./pkgs/albumentations {};
    amazon-s3-plugin-for-pytorch = final.callPackage additionalInputs.amazon-s3-plugin-for-pytorch {};
    aravis = final.callPackage ./pkgs/aravis  {};
    darkflow = final.callPackage ./pkgs/darkflow  {};
    efficientnet-pytorch = final.callPackage ./pkgs/efficientnet-pytorch  {};
    einops = final.callPackage ./pkgs/einops {};
    ideepcolor = final.callPackage ./pkgs/ideepcolor  {};
    imagenet-utils = final.callPackage ./pkgs/imagenet-utils  {};
    keras = final.callPackage ./pkgs/keras {};
    keras-resnet = final.callPackage ./pkgs/keras-resnet  {};
    keras-retinanet = final.callPackage ./pkgs/keras-retinanet  {};
    kornia = final.callPackage ./pkgs/kornia {};
    labelimg = final.callPackage ./pkgs/labelimg  {};
    # numpy = final.callPackage ./pkgs/numpy  {};
    openpano = final.callPackage ./pkgs/openpano  {};
    pretrainedmodels = final.callPackage ./pkgs/pretrainedmodels  {};
    qdarkstyle = final.callPackage ./pkgs/qdarkstyle  {};
    segmentation-models-pytorch = final.callPackage ./pkgs/segmentation-models-pytorch  {};
    timm = final.callPackage ./pkgs/timm  {};
    # torchvision = final.callPackage ./pkgs/torchvision  {};
    wandb = final.callPackage ./pkgs/wandb  {};
    yaspin = final.callPackage ./pkgs/yaspin  {};
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
      };
in
{
  inherit pythonOverrides;
  inherit (packagesetOverlays) python37 python38 python39 python310;
}

