let
  pythonOverrides = pythonFinal: pythonPrev: {
    albumentations = pythonFinal.callPackage ./pkgs/albumentations {};
    aravis = pythonFinal.callPackage ./pkgs/aravis  {};
    darkflow = pythonFinal.callPackage ./pkgs/darkflow  {};
    efficientnet-pytorch = pythonFinal.callPackage ./pkgs/efficientnet-pytorch  {};
    einops = pythonFinal.callPackage ./pkgs/einops {};
    ideepcolor = pythonFinal.callPackage ./pkgs/ideepcolor  {};
    imagenet-utils = pythonFinal.callPackage ./pkgs/imagenet-utils  {};
    keras-resnet = pythonFinal.callPackage ./pkgs/keras-resnet  {};
    keras-retinanet = pythonFinal.callPackage ./pkgs/keras-retinanet  {};
    kornia = pythonFinal.callPackage ./pkgs/kornia {};
    labelimg = pythonFinal.callPackage ./pkgs/labelimg  {};
    # numpy = pythonFinal.callPackage ./pkgs/numpy  {};
    openpano = pythonFinal.callPackage ./pkgs/openpano  {};
    pretrainedmodels = pythonFinal.callPackage ./pkgs/pretrainedmodels  {};
    pytorch-bin = pythonFinal.callPackage ./pkgs/pytorch/bin.nix  {};
    # pytorch = pythonFinal.callPackage ./pkgs/pytorch {};
    pytorch = pythonFinal.pytorch-bin;
    qdarkstyle = pythonFinal.callPackage ./pkgs/qdarkstyle  {};
    segmentation-models-pytorch = pythonFinal.callPackage ./pkgs/segmentation-models-pytorch  {};
    timm = pythonFinal.callPackage ./pkgs/timm  {};
    # torchvision = pythonFinal.callPackage ./pkgs/torchvision  {};
    wandb = pythonFinal.callPackage ./pkgs/wandb  {};
    yaspin = pythonFinal.callPackage ./pkgs/yaspin  {};
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

