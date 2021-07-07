{ buildPythonPackage
, fetchPypi
, lib
, pyyaml
, scikitimage
, opencv4
, pytest
, imgaug
, pytorch
}:

buildPythonPackage rec {
  version = "1.0.1";
  pname   = "albumentations";

  src = fetchPypi {
    inherit pname version;
    sha256 = "0g8x5qjwgxl0y44d8g6wx82fhyjib7j6h82db0l97ag78wb0843y";
  };

  propagatedBuildInputs = [ pyyaml scikitimage opencv4 ];


  postPatch = ''
    substituteInPlace setup.py \
      --replace "\"opencv-python-headless>=4.1.1\"" "\"\""
  '';

  checkInputs = [
    pytest
    pytorch
    imgaug
  ];

  doCheck = false; # imgaug fails its own tests

  meta = {
    description = "Fast image augmentation library and easy to use wrapper around other libraries";
    homepage    = "https://github.com/albumentations-team/albumentations";
    license     = lib.licenses.mit;
    maintainers = with lib.maintainers; [];
  };
}
