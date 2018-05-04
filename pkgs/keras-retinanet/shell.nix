{ pkgs ? import <nixpkgs> { overlays = [ (import ../../shell-overlays.nix) ]; }
}:

let
  drv = pkgs.callPackage ./default.nix {
    python = pkgs.python3;
    pythonPackages = pkgs.python3Packages;
    keras-resnet = pkgs.callPackage ../keras-resnet/default.nix { python = pkgs.python3; pythonPackages = pkgs.python3Packages; };
  };

  drvPatched = drv.overrideDerivation (oldAttrs: {
    patches = [
      # You might find it useful to supply your own classes for the pascal voc dataset
      # e.g.
      #
      #   diff --git a/keras_retinanet/preprocessing/pascal_voc.py b/keras_retinanet/preprocessing/pascal_voc.py
      #   index e273aac..4168a4d 100644
      #   --- a/keras_retinanet/preprocessing/pascal_voc.py
      #   +++ b/keras_retinanet/preprocessing/pascal_voc.py
      #   @@ -28,26 +28,45 @@ except ImportError:
      #        import xml.etree.ElementTree as ET
      #    
      #    voc_classes = {
      #   -    'aeroplane'   : 0,
      #   -    'bicycle'     : 1,
      #   -    'bird'        : 2,
      #   -    'boat'        : 3,
      #   -    'bottle'      : 4,
      #   -    'bus'         : 5,
      #   -    'car'         : 6,
      #   -    'cat'         : 7,
      #   -    'chair'       : 8,
      #   -    'cow'         : 9,
      #   -    'diningtable' : 10,
      #   -    'dog'         : 11,
      #   -    'horse'       : 12,
      #   -    'motorbike'   : 13,
      #   -    'person'      : 14,
      #   -    'pottedplant' : 15,
      #   -    'sheep'       : 16,
      #   -    'sofa'        : 17,
      #   -    'train'       : 18,
      #   -    'tvmonitor'   : 19
      #   +    'a': 0,
      #   +    'b': 1,
      #   +    'c': 2,
      #   +    'd': 3,
      #    }
      #
      ./pascal_voc_classes.patch
    ];
  });
in
  pkgs.stdenv.mkDerivation {
    name = "keras-retinanet-environment";
    version = "0.0.0";
    buildInputs =
      # Nix shell dependencies
      with pkgs;
      [
        drvPatched
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
        echo "keras-retinanet environment"
        echo "--------------------"
        printf "${nc}"
        echo
        echo 'Example usage:'
        echo
        echo 'Train your own dataset: (hint: start out simple)'
        echo
        echo '  retinanet-train --steps 1000 pascal $PATH_TO_PASCAL_DATASET'
        echo '  retinanet-convert-model ./snapshots/resnet50_pascal_50.h5 inference_model.h5'
        echo
        echo 'Train '
        echo
        echo '  retinanet-train --steps 1000 pascal $PATH_TO_PASCAL_DATASET'
        echo '  retinanet-convert-model ./snapshots/resnet50_pascal_50.h5 inference_model.h5'
        echo
        echo 'Test against a test dataset:'
        echo
        echo '  retinanet-evaluate pascal $PATH_TO_PASCAL_DATASET inference_model.h5'
        echo
        echo 'Play with the example notebook (remember to first install jupyter):'
        echo
        echo '  cp -r ${drv.src}/examples .'
        echo '  chmod -R u+w ./examples'
        cat << EndOfString
          nix-shell \\
            -p python3Packages.jupyter \\
            -p python3Packages.matplotlib \\
            --run 'jupyter-notebook --notebook-dir ./examples'
        EndOfString
        echo
        '';
  }
