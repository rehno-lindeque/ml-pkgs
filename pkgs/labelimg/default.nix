{
  makeWrapper,
  fetchFromGitHub,
  python,
  buildPythonApplication,
  pillow,
  pyqt4,
  numpy,
  opencv,
  lxml,
}: let
  pythonDeps = [pyqt4 numpy opencv lxml];
in
  buildPythonApplication rec {
    version = "dev";
    name = "labelImg-${version}";
    src = fetchFromGitHub {
      owner = "tzutalin";
      repo = "labelImg";
      rev = "a7fc85270fa1cb34afdc2da1f17fe17f6798e5a1";
      sha256 = "0bjwbxxd8qf7424pv6sz91ysfwsq85bg8rbf006nxfrhcvgjb3gq";
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

    buildInputs = [makeWrapper pillow] ++ pythonDeps;
    propagatedBuildInputs = [python];
  }
