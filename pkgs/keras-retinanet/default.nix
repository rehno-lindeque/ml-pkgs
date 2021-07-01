{ fetchFromGitHub
, buildPythonPackage
, python
, tensorflow, Keras, six, scipy, opencv3, pillow, h5py, keras-resnet
}:

let
  keras-retinanet =
    (buildPythonPackage rec {
      version = "dev";
      name = "keras-retinanet-${version}";
      src = fetchFromGitHub {
        owner = "fizyr";
        repo = "keras-retinanet";
        rev = "0d89a33bace90591cad7882cf0b1cdbf0fbced43";
        sha256 = "0n10mwingnpqaqk0s84y3sp7fkyjxmz9lizqr98ag3vfb3lac7h6";
      };
      propagatedBuildInputs =
        [
          python
          tensorflow
          Keras
          six
          scipy
          # opencv3WithoutCuda
          opencv3
          pillow
          h5py
          keras-resnet
        ];
      doCheck = false;
    });
in
  keras-retinanet

