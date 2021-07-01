{ buildPythonPackage
, fetchPypi
, lib
, pytorch
}:

buildPythonPackage rec {
  # version = "0.7.1";
  version = "0.6.3";
  pname   = "efficientnet_pytorch";

  src = fetchPypi {
    inherit pname version;
    # sha256 = "1q8ygjdl7b7clynl23s7fm8sd8i9ihisvqma8wnrvrgwxxhv5f80";
    sha256 = "17ri78kvc112py16ffyscmzxkzj9lj5piqvx6vv9ngl96s9larv6";
  };

  propagatedBuildInputs = [ pytorch ];

  meta = {
    description = "EfficientNet implemented in PyTorch";
    homepage    = "https://github.com/lukemelas/EfficientNet-PyTorch";
    license     = lib.licenses.mit;
    maintainers = with lib.maintainers; [];
  };
}
