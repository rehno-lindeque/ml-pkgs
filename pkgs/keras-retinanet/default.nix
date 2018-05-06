{ fetchFromGitHub
, python
, pythonPackages
, keras-resnet
}:

let
  keras-retinanet =
    (pythonPackages.buildPythonPackage rec {
      version = "dev";
      name = "keras-retinanet-${version}";
      src = fetchFromGitHub {
        owner = "fizyr";
        repo = "keras-retinanet";
        rev = "0d89a33bace90591cad7882cf0b1cdbf0fbced43";
        sha256 = "0n10mwingnpqaqk0s84y3sp7fkyjxmz9lizqr98ag3vfb3lac7h6";
      };
      propagatedBuildInputs =
        (with pythonPackages; [
          tensorflow
          Keras
          six
          scipy
          opencv3
          pillow
          h5py
        ])
        ++ [
          keras-resnet
          python
        ];
      doCheck = false;
    });
in
  keras-retinanet

