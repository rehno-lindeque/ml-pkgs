{
  fetchFromGitHub,
  python,
  pythonPackages,
}:
pythonPackages.buildPythonPackage rec {
  version = "dev";
  name = "keras-retinanet-${version}";
  src = fetchFromGitHub {
    owner = "broadinstitute";
    repo = "keras-resnet";
    rev = "7160dd5cf8f97b2bb70a72e6f1eba5ad867cd1a1";
    sha256 = "0qyzbyyy7lv0g1lbhllc71gs0n09if9b34hvdsh2y9ynfzd9l8sw";
  };
  propagatedBuildInputs =
    (with pythonPackages; [
      tensorflow
      Keras
    ])
    ++ [
      python
    ];
  doCheck = false;
}
