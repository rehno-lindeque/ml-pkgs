{pkgs ? import <nixpkgs> {}}: let
  python = pkgs.python38.override {
    packageOverrides = python-self: python-super: {
      segmentation-models-pytorch = python-self.callPackage ./. {};
      efficientnet-pytorch = python-self.callPackage ../efficientnet-pytorch {};
      timm = python-self.callPackage ../timm {};
      pretrainedmodels = python-self.callPackage ../pretrainedmodels {};
    };
  };
  pythonEnv = python.withPackages (
    ps:
      with ps; [
        segmentation-models-pytorch
      ]
  );
in
  pkgs.mkShell {
    buildInputs = [
      pythonEnv
    ];
    shellHook = let
      nc = "\\e[0m"; # No Color
      white = "\\e[1;37m";
      black = "\\e[0;30m";
      blue = "\\e[0;34m";
      light_blue = "\\e[1;34m";
      green = "\\e[0;32m";
      light_green = "\\e[1;32m";
      cyan = "\\e[0;36m";
      light_cyan = "\\e[1;36m";
      red = "\\e[0;31m";
      light_red = "\\e[1;31m";
      purple = "\\e[0;35m";
      light_purple = "\\e[1;35m";
      brown = "\\e[0;33m";
      yellow = "\\e[1;33m";
      grey = "\\e[0;30m";
      light_grey = "\\e[0;37m";
    in ''
      echo ""
      printf "${white}"
      echo "-----------------------------------------------"
      echo "segmentation-models-pytorch sandbox environment"
      echo "-----------------------------------------------"
      printf "${nc}"
      echo
    '';
  }
