{
  description = "My collection of machine learning packages for nix";
 
  outputs = { self, ... }: {
    overlay = final: prev: {
      albumentations = final.callPackage ./pkgs/albumentations  {};
      aravis = final.callPackage ./pkgs/aravis  {};
      darkflow = final.callPackage ./pkgs/darkflow  {};
      efficientnet-pytorch = final.callPackage ./pkgs/efficientnet-pytorch  {};
      einops = final.callPackage ./pkgs/einops  {};
      ideepcolor = final.callPackage ./pkgs/ideepcolor  {};
      imagenet-utils = final.callPackage ./pkgs/imagenet-utils  {};
      keras-resnet = final.callPackage ./pkgs/keras-resnet  {};
      keras-retinanet = final.callPackage ./pkgs/keras-retinanet  {};
      kornia = final.callPackage ./pkgs/kornia {};
      labelimg = final.callPackage ./pkgs/labelimg  {};
      # numpy = final.callPackage ./pkgs/numpy  {};
      openpano = final.callPackage ./pkgs/openpano  {};
      pretrainedmodels = final.callPackage ./pkgs/pretrainedmodels  {};
      pytorch-bin = final.callPackage ./pkgs/pytorch/bin.nix  {};
      # pytorch = final.callPackage ./pkgs/pytorch {};
      pytorch = final.pytorch-bin;
      qdarkstyle = final.callPackage ./pkgs/qdarkstyle  {};
      segmentation-models-pytorch = final.callPackage ./pkgs/segmentation-models-pytorch  {};
      timm = final.callPackage ./pkgs/timm  {};
      # torchvision = final.callPackage ./pkgs/torchvision  {};
      wandb = final.callPackage ./pkgs/wandb  {};
      yaspin = final.callPackage ./pkgs/yaspin  {};
    };
  };
}
