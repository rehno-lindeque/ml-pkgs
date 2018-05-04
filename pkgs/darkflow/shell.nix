{ pkgs ? import <nixpkgs> {}
}:

let
  drv = pkgs.callPackage ./default.nix {
    python = pkgs.python3;
    pythonPackages = pkgs.python3Packages;
  };
in
pkgs.stdenv.mkDerivation {
    name = "darkflow-environment";
    version = "0.0.0";
    buildInputs =
      # Nix shell dependencies
      with pkgs;
      [
        drv
        wget
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
        echo "--------------------"
        echo "Darkflow environment"
        echo "--------------------"
        printf "${nc}"
        echo
        echo 'Example usage:'
        echo
        echo 'Using downloaded weights
        echo
        echo '  flow --model cfg/v1/yolo-tiny.cfg --load download/yolo-tiny.weights'

        # echo '  # 1. Load tiny-yolo.weights'
        # echo '  flow --model cfg/tiny-yolo.cfg --load download/tiny-yolo.weights'
        # echo '  '
        # echo '  # 2. To completely initialize a model, leave the --load option'
        # echo '  flow --model cfg/yolo-new.cfg'
        # echo '  '
        # echo '  # 3. It is useful to reuse the first identical layers of tiny for `yolo-new`'
        # echo '  flow --model cfg/yolo-new.cfg --load download/tiny-yolo.weights'
        # echo '  # this will print out which layers are reused, which are initialized'

        echo
        echo 'Using a pascal dataset:'
        echo
        echo '  flow --imgdir $PATH_TO_PASCAL_DATASET/JPEGImages --model cfg/v1/yolo-tiny.cfg --annotation $PATH_TO_PASCAL_DATASET/Annotations'
        echo

        # if [ ! -d ./download ]; then
        #   mkdir ./download
        # fi
        # if [[ ! -f ./download/tiny-yolo.weights || ! -f ./download/tiny-yolo.cfg ]]; then
        #   if [ ! -f ./download/tiny-yolo.weights ]; then
        #       echo "Downloading tiny-yolo.weights"
        #       wget -O ./download/tiny-yolo.weights https://pjreddie.com/media/files/tiny-yolo.weights
        #   fi
        #   if [ ! -f ./download/yolo-voc.weights ]; then
        #       echo "Downloading yolo-voc.weights"
        #       wget -O ./download/yolo-voc.weights https://pjreddie.com/media/files/yolo-voc.weights
        #   fi
        #   echo "Done"
        # fi

        '';
  }
