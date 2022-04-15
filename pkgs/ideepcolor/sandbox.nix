{pkgs ? import <nixpkgs> {overlays = [(import ../../sandbox-overlays.nix)];}}: let
  drv = pkgs.pythonPackages.callPackage ./default.nix {
    python = pkgs.python2;
    pythonPackages = pkgs.python2Packages;
  };
in
  pkgs.stdenv.mkDerivation {
    name = "ideepcolor-sandbox";
    version = "0.0.0";
    buildInputs =
      # Nix shell dependencies
      with pkgs; [
        drv
        wget
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
      echo "-------------------------------------------------"
      echo "Interactive Deep Colorization sandbox environment"
      echo "-------------------------------------------------"
      printf "${nc}"
      echo
      # TODO: fetch_models has to be extracted from the source now actually
      echo 'To fetch models run: fetch_models'
      echo

      fetch_models() {
        ./models/fetch_models.sh
      }
    '';
  }
