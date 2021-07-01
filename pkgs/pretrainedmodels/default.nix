{ buildPythonPackage
, fetchPypi
, lib
, pytorch
, torchvision
, tqdm
, munch
}:

buildPythonPackage rec {
  version = "0.7.4";
  pname   = "pretrainedmodels";

  src = fetchPypi {
    inherit pname version;
    sha256 = "12mrf1jcrhn3gsix4zy86zzdyvmqsn52r6217jmi2glsc7aflxvy";
  };

  doCheck = false;

  propagatedBuildInputs = [ tqdm pytorch torchvision munch ];

  meta = {
    description = "Pretrained models for Pytorch";
    homepage    = "https://github.com/cadene/pretrained-models.pytorch";
    license     = lib.licenses.mit;
    maintainers = with lib.maintainers; [];
  };
}
