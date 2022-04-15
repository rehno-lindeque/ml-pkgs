{
  buildPythonPackage,
  fetchPypi,
  # , fetchurl
  python,
  six,
  numpy,
  pillow,
  pytorch,
  lib,
}:
buildPythonPackage rec {
  # version = "0.2.1";
  # version = "0.6.1";
  # version = "0.8.1";
  # version = "0.7.0";
  version = "0.8.2";
  pname = "torchvision";

  format = "wheel";

  src = fetchPypi {
    inherit pname version;
    format = "wheel";
    python = "cp38";
    abi = "cp38";
    platform = "manylinux1_x86_64";
    sha256 = "03svsssr051xmmkmfjiij5az7fwhvd2s8qkiwfx0xikz37lig26d";
    # sha256 = "0m2khx2p5rzz9qhig74nh6g72y82jwjha78migqj1kwspikv78ng";
  };
  # --editable

  propagatedBuildInputs = [six numpy pillow pytorch];

  postInstall = ''
    touch $out/${python.sitePackages}/torchvision/py.typed
  '';

  meta = {
    description = "PyTorch vision library";
    homepage = "https://pytorch.org/";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ericsagnes];
  };
}
