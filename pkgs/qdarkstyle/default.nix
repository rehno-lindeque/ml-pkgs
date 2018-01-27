{ pkgs ? import <nixpkgs> {}
, python
, pythonPackages
}:

pythonPackages.buildPythonPackage rec {
  pname = "qdarkstyle";
  version = "dev";
  name = "${pname}-${version}";
  # src = pythonPackages.fetchPypi {
  #   inherit pname version;
  #   sha256 = "0000000000000000000000000000000000000000000000000000";
  # };
  src = pkgs.fetchFromGitHub {
    owner = "ColinDuquesnoy";
    repo = "QDarkStyleSheet";
    rev = "6e2436c1c086c615395761f2b59f651b859dcc77";
    sha256 = "17d0ad610s5k9r7mlh73v70paih822gnfzdwaap1wpnsp3vbgbca";
  };
}
