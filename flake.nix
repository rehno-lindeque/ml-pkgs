{
  description = "My collection of machine learning packages for nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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
              config = {
                allowUnfree = true;
                cudaSupport = true;
                cudnnSupport = true;
              };
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
          amazon-s3-plugin-for-pytorch
          efficientnet-pytorch
          einops
          expecttest
          keras
          keras-resnet
          keras-retinanet
          kornia
          pretrainedmodels
          sacrebleu
          tensorflow-tensorboard
          # torchaudio
          # torchdata
          wandb
          yaspin

          # known out of date relative to nixpkgs pin (or otherwise broken):
          # albumentations
          # aravis
          # darkflow
          # ideepcolor
          # imagenet-utils
          # labelimg
          # openpano
          # qdarkstyle
          # segmentation-models-pytorch
          # timm
          # fairseq # doesn't build at the moment due to cmake version
          # torchtext
          ;
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
