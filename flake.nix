{
  description = "My collection of machine learning packages for nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    # Nixpkgs patching
    nixpkgs-unpatched.url = "github:nixos/nixpkgs/nixos-unstable";
    # kornia-patch = {
    #   url = "path:patches/193229.diff";
    #   url = "https://github.com/NixOS/nixpkgs/pull/193229.diff";
    #   flake = false;
    # };
    # segments-ai-patch = {
    #   url = "path:patches/191371.diff";
    #   url = "https://github.com/NixOS/nixpkgs/pull/191371.diff";
    #   flake = false;
    # };
    # torchdata-bin-patch = {
    #   url = "path:patches/187779.diff";
    #   url = "https://github.com/NixOS/nixpkgs/pull/187779.diff";
    #   flake = false;
    # };

    # Nix imports
    amazon-s3-plugin-for-pytorch = {
      url = "https://raw.githubusercontent.com/NixOS/nixpkgs/835b9f2b58277fac67eb96b5ab2d21f2315295e6/pkgs/development/python-modules/amazon-s3-plugin-for-pytorch/default.nix";
      flake = false;
    };
    pytorch-unstable = {
      url = "https://raw.githubusercontent.com/rehno-lindeque/nixpkgs/f43cfcd81387c453ef74da55e098cd076885a2b2/pkgs/development/python-modules/pytorch/unstable.nix";
      flake = false;
    };
    torchdata-unstable = {
      url = "https://raw.githubusercontent.com/rehno-lindeque/nixpkgs/7c1748a0e607bbfc24be50d13c6b54f671be5af5/pkgs/development/python-modules/torchdata/unstable.nix";
      flake = false;
    };
    expecttest = {
      url = "https://raw.githubusercontent.com/NixOS/nixpkgs/da2b767621fd538881e130d12ecdfdd3195727a3/pkgs/development/python-modules/expecttest/default.nix";
      flake = false;
    };
    sacrebleu = {
      url = "https://raw.githubusercontent.com/NixOS/nixpkgs/64ab7ab9debb6d93311083a735419f837d8d6022/pkgs/development/python-modules/sacrebleu/default.nix";
      flake = false;
    };
    fairseq = {
      url = "https://raw.githubusercontent.com/NixOS/nixpkgs/3b4512affed042a5bab8debdd6a41b0eb7d143da/pkgs/development/python-modules/fairseq/default.nix";
      flake = false;
    };
    torchtext = {
      url = "https://raw.githubusercontent.com/NixOS/nixpkgs/c96132b4a0df81106c91bddca6f895fe5d44469e/pkgs/development/python-modules/torchtext/default.nix";
      flake = false;
    };
    torchaudio = {
      url = "https://raw.githubusercontent.com/NixOS/nixpkgs/ffe409095cfcec679fe0f0a97db6adb4c0c6d32d/pkgs/development/python-modules/torchaudio/default.nix";
      flake = false;
    };
    tensorflow-tensorboard = {
      url = "https://raw.githubusercontent.com/rehno-lindeque/nixpkgs/e6997a4c433c117563443952e5de5cd4265d0065/pkgs/development/python-modules/tensorflow-tensorboard/default.nix";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }: let
    nixpkgs-patched = (nixpkgs.legacyPackages.x86_64-linux.applyPatches {
      name = "nixpkgs-patched";
      src = self.inputs.nixpkgs-unpatched;
      patches = [
        ./patches/219854.diff # kornia-patch
        ./patches/191371.diff # segments-ai-patch
        ./patches/187779.diff # torchdata-bin-patch
        # self.inputs.kornia-patch
        # self.inputs.segments-ai-patch
        # self.inputs.torchdata-bin-patch
      ];
    }).outPath;

    # pytorch is not available on aarch64 for now
    eachEnvironment = f:
      flake-utils.lib.eachSystem [flake-utils.lib.system.x86_64-linux]
      (
        system:
          f {
            inherit system;
            pkgs = import nixpkgs {
              inherit system;
              config = {
                allowUnfree = true;
                cudaSupport = true;
                cudnnSupport = true;
              };
              overlays = [
                self.overlays.default
              ];
            };
          }
      );
  in
    eachEnvironment ({
      pkgs,
      system,
    }: {
      packages = {
        inherit
          (pkgs.python3Packages)
          amazon-s3-plugin-for-pytorch
          efficientnet-pytorch
          einops
          expecttest
          keras
          keras-resnet
          keras-retinanet
          kornia
          pretrainedmodels
          pytorch
          pytorch-bin
          pytorch-nightly-bin
          pytorch-unstable
          sacrebleu
          segments-ai
          tensorflow-tensorboard
          torchaudio-nightly-bin
          torchdata-bin
          torchdata-nightly-bin
          torchdata-unstable
          torchtext-nightly-bin
          torchvision-nightly-bin
          types-pillow
          yaspin
          ;

        # Known out of date relative to nixpkgs pin (or otherwise broken):
        # albumentations
        # aravis
        # darkflow
        # deep-chainmap
        # ideepcolor
        # imagenet-utils
        # labelimg
        # openpano
        # qdarkstyle
        # segmentation-models-pytorch
        # timm
        # fairseq # doesn't build at the moment due to cmake version
        # torchtext
        # wandb
      };
    })
    // {
      overlays = import ./overlays.nix { flake = self; inherit nixpkgs-patched; };

      checks = self.packages;
    };
}
