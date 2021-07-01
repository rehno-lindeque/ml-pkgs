{ buildPythonPackage
, fetchPypi
, lib
, pytorch
, torchvision
, pretrainedmodels
}:

buildPythonPackage rec {
  # version = "0.4.12";
  version = "0.3.2";
  pname   = "timm";
  format = "wheel";

  src = fetchPypi {
    inherit pname version;
    format = "wheel";
    python = "py3";
    # sha256 = "07jbi17bb1a71zlgzyzbv71ihy9ccz15pksphv5baa25pl6yfjxi";
    sha256 = "0xbq7346b5ggqd6xak34dgjjmmmqvh8li0vbba1khvi43kv8wnf1";
  };

  propagatedBuildInputs = [ pytorch torchvision pretrainedmodels ];
  doCheck = false;

  meta = {
    description = "(Unofficial) PyTorch Image Models";
    homepage    = "https://github.com/rwightman/pytorch-image-models";
    license     = lib.licenses.asl20;
    maintainers = with lib.maintainers; [];
  };
}
