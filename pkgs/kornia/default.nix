{
  buildPythonPackage,
  fetchPypi,
  lib,
  packaging,
  pytest,
  pytest-runner,
  pytorch,
}:
buildPythonPackage rec {
  pname = "kornia";
  version = "0.6.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "1mnwbwlhsv2f1mbxacbiizyqbm5n23sn5hb6b1a6d1pq14rznf7n";
  };

  buildInputs = [
    pytest-runner
  ];

  checkInputs = [
    pytest
  ];

  propagatedBuildInputs = [
    packaging
    pytorch
  ];

  doCheck = false; # test fails for unknown reason atm

  pythonImportsCheck = ["kornia"];

  meta = with lib; {
    description = "Kornia is a differentiable library that allows classical computer vision to be integrated into deep learning models.";
    homepage = "https://kornia.readthedocs.io/";
    license = licenses.asl20;
    maintainers = with maintainers; [];
  };
}
