{ makeWrapper
, fetchFromGitHub
, python
, buildPythonApplication
, pillow, pyqt4, numpy, opencv, lxml
}:

let

  pythonDeps = [ pyqt4 numpy opencv lxml ];

in

buildPythonApplication rec {
  version = "dev";
  name = "labelImg-${version}";
  src = fetchFromGitHub {
    owner = "tzutalin";
    repo = "labelImg";
    rev = "821ffae6b9f55786b792765ef0cbe2652a4285a9";
    sha256 = "1nb153adx0crw9pfzpvrnc730fnfjjgyg2ygp2z692yaza7a3rr8";
  };

  pythonPath = pythonDeps;

  installPhase = ''
    make all
    mkdir -p $out/bin
    mkdir -p $out/lib/${python.libPrefix}/site-packages
    install -m 0755 *.py $out/bin
    cp -r libs $out/lib/${python.libPrefix}/site-packages/libs
    chmod +x $out/bin/*.py

    wrapPythonPrograms
  '';

  doCheck = false;

  buildInputs = [ makeWrapper pillow ] ++ pythonDeps;
  propagatedBuildInputs = [ python ];
}
