{ pkgs ? import <nixpkgs> { overlays = [ (import ../../sandbox-overlays.nix) ]; }
}:

let
  drv = pkgs.callPackage ./default.nix { gst_all = pkgs.gst_all_1; };
in
  pkgs.stdenv.mkDerivation {
    name = "aravis-sandbox";
    version = "0.0.0";
    buildInputs =
      # Nix shell dependencies
      with pkgs;
      [
        drv
      ];
    shellHook =
      let
        nc="\\e[0m"; # No Color
        white="\\e[1;37m";
        black="\\e[0;30m";
        blue="\\e[0;34m";
        light_blue="\\e[1;34m";
        green="\\e[0;32m";
        light_green="\\e[1;32m";
        cyan="\\e[0;36m";
        light_cyan="\\e[1;36m";
        red="\\e[0;31m";
        light_red="\\e[1;31m";
        purple="\\e[0;35m";
        light_purple="\\e[1;35m";
        brown="\\e[0;33m";
        yellow="\\e[1;33m";
        grey="\\e[0;30m";
        light_grey="\\e[0;37m";
      in
        ''
        echo ""
        printf "${white}"
        echo "----------------------------"
        echo "aravis sandbox environment"
        echo "----------------------------"
        printf "${nc}"
        echo
        echo 'Example usage:'
        echo
        echo '  arv-viewer'
        echo
        '';
  }

