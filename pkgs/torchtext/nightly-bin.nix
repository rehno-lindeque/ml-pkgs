{ lib
, stdenv
, buildPythonPackage
, fetchurl
, isPy37
, isPy38
, isPy39
, isPy310
, python

# Propogated build inputs
, pytorch
, tqdm
}:

let
  pyVerNoDot = builtins.replaceStrings [ "." ] [ "" ] python.pythonVersion;
  version = "0.13.0";
  date = "20220420";
  srcs = import ./nightly-binary-hashes.nix { inherit version date; };
  unsupported = throw "Unsupported system";
in buildPythonPackage {
  pname = "torchtext";
  version = "${version}-${date}";
  format = "wheel";

  src = fetchurl (srcs."${stdenv.system}-${pyVerNoDot}" or unsupported);

  disabled = !(isPy37 || isPy38 || isPy39 || isPy310);

  propagatedBuildInputs = [
    pytorch
    tqdm
  ];

  pythonImportsCheck = [ "torchtext" ];

  meta = with lib; {
    description = "PyTorch text library";
    homepage = "https://pytorch.org/";
    changelog = "https://github.com/pytorch/text/releases/tag/v${version}";
    license = licenses.bsd3;
    platforms = platforms.linux;
    maintainers = with maintainers; [];
  };
}
