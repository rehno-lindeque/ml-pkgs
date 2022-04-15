{
  pkgs ? import <nixpkgs> {},
  python,
  pythonPackages,
  opencv3,
}: let
  opencv = opencv3.override {
    # enableIpp       =
    # enableContrib   =
    # enableGtk3      =
    # enableFfmpeg    =
    # enableGStreamer =
    # enableDocs      =
    # enableUnfree    =
    # enableTesseract =
    # enableOvis      =
    # enableGPhoto2   =
    # enableDC1394    =
  };
  # # used for creating annotations
  # imageNetUtils =
  #   pkgs.callPackage ../imagenet-utils/default.nix {
  #     python = pkgs.python2;
  #     pythonPackages = pkgs.python2Packages;
  #   };
  # labelimg =
  #   pkgs.callPackage ./labelimg/default.nix {
  #     python = pkgs.python2;
  #     pythonPackages = pkgs.python2Packages;
  #   };
  darkflow = pythonPackages.buildPythonPackage rec {
    # https://github.com/thtrieu/darkflow
    # https://github.com/llSourcell/YOLO_Object_Detection
    version = "dev";
    name = "darkflow-${version}";
    src = ./.;
    propagatedBuildInputs = [
      python
      pythonPackages.cython
      pythonPackages.tensorflow
      opencv
      # imageNetUtils
    ];
  };
in [
  # imageNetUtils
  # imageNetUtils.gui
  # labelimg
  # pkgs.python2
  darkflow
]
