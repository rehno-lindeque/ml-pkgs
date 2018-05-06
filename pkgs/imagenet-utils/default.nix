{ pkgs ? import <nixpkgs> {}
, python
, pythonPackages
, mkPythonDerivation
}:

let

  toPythonLibPath = (m: "${m}/lib/${python.libPrefix}/site-packages");

  pythonDeps = with pythonPackages; [ pyqt4 numpy opencv lxml ];
  # pythonDeps = with pythonPackages; [ pyqt4 numpy imread ];

in

# pythonPackages.buildPythonApplication rec {
# pkgs.stdenv.mkDerivation rec {
mkPythonDerivation rec {
  version = "dev";
  name = "ImageNet_Utils-${version}";
  src = pkgs.fetchFromGitHub {
    owner = "tzutalin";
    repo = "ImageNet_Utils";
    rev = "b05e50a4d8531c403772b3e8e6371101fc45e5fb";
    # sha256 = "0ranvvaxhzzg01a377176b4qxp8naaz58z9hy07y9kq391a7sd2s";
    sha256 = "1dzdnnj798ays5z091q5l92rapl8a5sx6pj5i2mdf1vnb7mc7l7y";
    fetchSubmodules = true;
  };

  # pythonPath = with pythonPackages; [ dbus-python pygobject3 pycairo ];
  # pythonPath = with pythonPackages; [ pillow ];
  # pythonPath = pythonDeps; #  ++ [ "${src}/labelImgGUI/libs" ];
  pythonPath = pythonDeps; # ++ [ "$gui/lib" ];


  # propagatedUserEnvPkgs = [ obex_data_server ];

  # configureFlags = [ (lib.enableFeature withPulseAudio "pulseaudio") ];

  # postFixup = ''
  #   makeWrapperArgs="--prefix PATH ':' ${binPath}"
  #   # This mimics ../../../development/interpreters/python/wrap.sh
  #   wrapPythonProgramsIn "$out/bin" "$out $pythonPath"
  #   wrapPythonProgramsIn "$out/libexec" "$out $pythonPath"
  # '';




  # sourceRoot = ".";
  # unpackCmd = ''
  #   ar p "$src" data.tar.xz | tar xJ
  # '';
  # unpackPhase = ''
  #   unzip $src
  #   sourceRoot=`pwd`/PDFRead/src
  # '';


  # buildPhase = ":";   # nothing to build



#   installPhase = ''
#     # mkdir -p $out/bin
#     # mkdir -p $out/share/src
#     # install -m 0755 $src/*.py $out/share/src
#     # install -m 0755 $src/*.py $out/bin
#     # install -m 0755 $src/bbox_helper.py $out/bin/bbox_helper
#     # ${python}/bin/2to3 --write $out/bin/bbox_helper



#     mkdir -p $out/bin
#     # cp bbox_helper.py $out/bin
#     install -m 0755 bbox_helper.py $out/bin/bbox_helper.py
#     chmod +x $out/bin/bbox_helper.py
#     LIBSUFFIX=lib/${python.libPrefix}/site-packages/
#     PYDIR=$out/$LIBSUFFIX
#     mkdir -p $PYDIR
#     cp -R *.py $PYDIR

#     export pythonpath="$PYTHONPATH"

#     wrapProgram $out/bin/bbox_helper.py --prefix PYTHONPATH : $PYTHONPATH:${pythonPackages.pillow}/$LIBSUFFIX/PIL

#     # wrapProgram $out/bin/bbox_helper.py \
#     #   --prefix PYTHONPATH : $PYTHONPATH:${pythonPackages.pillow}/$LIBSUFFIX/PIL:$PYDIR \
#     #   --prefix PATH : ${pkgs.stdenv.lib.makeBinPath [ pkgs.curl ]}

#     # wrapProgram $out/bin/bbox_helper.py \
#     #   --prefix PYTHONPATH : $PYTHONPATH:${toPythonLibPath pythonPackages.pillow}:$PYDIR \
#     #   --prefix PATH : ${pkgs.stdenv.lib.makeBinPath [ pkgs.curl ]}

#     # This mimics ../../../development/interpreters/python/wrap.sh (?)
#     # wrapPythonProgramsIn "$out/bin" "$out $pythonPath"
#     # wrapPythonProgramsIn "$out/libexec" "$out $pythonPath"

#     # wrapPythonPrograms "$out/bin" "$out $pythonPath" \
#     #   --prefix PYTHONPATH : $PYTHONPATH:${toPythonLibPath pythonPackages.pillow}/PIL:$PYDIR
#   '';

#   installPhase = ''
#     mkdir -p $out/bin
#     install -m 0755 bbox_helper.py $out/bin/bbox_helper.py
#     chmod +x $out/bin/bbox_helper.py
#     # addToSearchPath program_PYTHONPATH ${toPythonLibPath pythonPackages.pillow}/PIL
#     addToSearchPath program_PYTHONPATH ${toPythonLibPath pythonPackages.pillow}
#     echo
#     echo "========================================================================"
#     echo "========================================================================"
#     echo
#     echo "$program_PYTHONPATH"
#     # Unfortunately due to bbox_helper using weird paths, it is not possible to use wrapPythonPrograms directly
#     # instead we go directly to patchPythonScript
#     substituteInPlace $out/bin/bbox_helper.py \
#       --replace 'import Image' 'from PIL import Image'
#     patchPythonScript $out/bin/bbox_helper.py
#     echo
#     echo "========================================================================"
#     echo "========================================================================"
#     echo
#     echo "$program_PYTHONPATH"
#   '';

  outputs = [ "out" "gui" ];

  # Needed for wrapPythonProgramsIn

  installPhase = ''
    echo $gui
    mkdir -p $out/bin
    install -m 0755 *.py $out/bin
    chmod +x $out/bin/*.py
    for f in $out/bin/*.py; do
      substituteInPlace "$f" \
        --replace 'import Image' 'from PIL import Image'
    done
    wrapPythonPrograms

    cd labelImgGUI
    make all
    mkdir -p $gui/bin
    # mkdir -p $gui/bin/libs
    # mkdir -p $gui/lib
    mkdir -p $gui/lib/${python.libPrefix}/site-packages
    install -m 0755 *.py $gui/bin
    # install -m 0755 libs/*.py $gui/bin/libs
    # install -m 0755 libs/*.py $gui/lib
    install -m 0755 libs/*.py $gui/lib/${python.libPrefix}/site-packages

    chmod +x $gui/bin/*.py
    echo "=========="
    echo $pythonPath
    echo "=========="
    # addToSearchPath program_PYTHONPATH $gui/lib

    echo "=========="
    echo $program_PYTHONPATH
    echo "=========="
    # _addToPythonPath $gui/lib
    wrapPythonProgramsIn $gui/bin "$gui $pythonPath"
  '';



  # postInstall = ":";
  # fixupPhase = ":";
  doCheck = false;

  # postInstall = ''
  #   wrapProgram $out/bin/bbox_helper \
  #     --prefix PATH : ${pkgs.stdenv.lib.makeBinPath [ pythonPackages.pillow ]}
  # '';
  # postInstall = ''
  #  mkdir -p $out/bin
  #  cp pdfread.py $out/bin
  #  chmod +x $out/bin/pdfread.py
   
  #  LIBSUFFIX=lib/${python.libPrefix}/site-packages/
  #  PYDIR=$out/$LIBSUFFIX
  #  mkdir -p $PYDIR
  #  cp -R *.py pylrs $PYDIR
  #   wrapProgram $out/bin/bbox_helper \
  #     --prefix PYTHONPATH : $PYTHONPATH:${pythonPackages.pillow}/$LIBSUFFIX/PIL:$PYDIR \
  #     --prefix PATH : ${pkgs.stdenv.lib.makeBinPath [ pkgs.curl ]}
  # '';




  # cp -R usr/share opt $out/
  # # fix the path in the desktop file
  # substituteInPlace \
  #   $out/share/applications/masterpdfeditor4.desktop \
  #   --replace /opt/ $out/opt/
  # # symlink the binary to bin/
  # ln -s $out/opt/master-pdf-editor-4/masterpdfeditor4 $out/bin/masterpdfeditor4
  # preFixup = let
  #   # we prepare our library path in the let clause to avoid it become part of the input of mkDerivation
  #   libPath = lib.makeLibraryPath [
  #     qt5.qtbase        # libQt5PrintSupport.so.5
  #     qt5.qtsvg         # libQt5Svg.so.5
  #     stdenv.cc.cc.lib  # libstdc++.so.6
  #     saneBackends      # libsane.so.1
  #   ];
  # in ''
  #   patchelf \
  #     --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
  #     --set-rpath "${libPath}" \
  #     $out/opt/master-pdf-editor-4/masterpdfeditor4
  # '';
  # buildInputs = [ pkgs.makeWrapper python pythonPackages.pillow ];
  # buildInputs = [ pkgs.makeWrapper ] ++ pythonPath;
  buildInputs = with pkgs; with pythonPackages; [ makeWrapper pillow ] ++ pythonDeps;
  propagatedBuildInputs = [ python ];
  # propagatedBuildInputs = with pythonPackages; [ python ];
}
