{
  description = "My collection of machine learning packages for nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?branch=nixos-21.11&rev=604c44137d97b5111be1ca5c0d97f6e24fbc5c2c";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    let
      # pytorch is not available on aarch64 for now
      eachEnvironment = f: flake-utils.lib.eachSystem [ flake-utils.lib.system.x86_64-linux ]
        (
          system:
          f {
            inherit system;
            pkgs = import nixpkgs {
              inherit system;
              config.allowUnfree = true;
              overlays = [
                self.overlays.python39
              ];
            };
          }
        );
    in
    eachEnvironment ({ pkgs, system }: {

      packages = {
        inherit (pkgs.python3Packages)
          albumentations
          # aravis
          # darkflow
          efficientnet-pytorch
          einops
          # ideepcolor
          # imagenet-utils
          keras
          keras-resnet
          keras-retinanet
          kornia
          # labelimg
          # openpano
          pretrainedmodels
          pytorch-bin
          pytorch
          # qdarkstyle
          # segmentation-models-pytorch
          # timm
          wandb
          yaspin;
      };

    }) // {

      # Default overlay with overrides included for current python 3.x package sets
      overlay = final: prev:
        (final.composeManyExtensions
          [ self.overlays.python37
            self.overlays.python38
            self.overlays.python39
            self.overlays.python310
          ]
          final) prev;

      overlays = import ./overlays.nix;

      checks = self.packages;

    };
}
