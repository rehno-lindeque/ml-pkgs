{ lib, stdenv, fetchurl, fetchzip, fetchFromGitHub
, eigen3_3
, cmake
, pkgconfig
# , gstreamer, xineLib, glib, python, pythonPackages, unzip, doxygen, perl
, libjpeg
# , libpng, libtiff, jasper, ffmpeg
# , gstreamer, xineLib, glib, python, pythonPackages, unzip, doxygen, perl
}:

let
  v = "0.0.0";

  enabled = condition : if condition then "ON" else "OFF";

in

stdenv.mkDerivation rec {
  name = "openpano-${v}";
  src = fetchFromGitHub {
    owner = "ppwwyyxx";
    repo = "openpano";
    rev = "d1a4aceca0d8bb151da71dc45b55050c76184643";
    sha256 = "01n8s61a9bpkmpdwv2prd7gqjdjd2gj5m6895n7p77acyy3jqx2m";
  };

  # patchPhase = ''
  #   sed -i "s|/usr/bin/perl|${perl}/bin/perl|" doc/Doxyfile.in
  # '';

  # postBuild = ''
  #   make doxygen
  # '';

  buildInputs = [ eigen3_3 libjpeg ];
  # buildInputs =
  #   [ unzip doxygen perl libjpeg libpng libtiff ];

  # propagatedBuildInputs =
  #   lib.optionals enableBloat [ pythonPackages.numpy ];

  nativeBuildInputs = [ cmake pkgconfig ];

  cmakeFlags = [];
  # cmakeFlags = [
  #   "-DWITH_IPP=${enabled enableIpp}"
  #   "-DWITH_OPENGL=${enabled enableOpenGL}"
  #   "-DWITH_QT=${enabled enableQT}"
  #   "-DINSTALL_C_EXAMPLES=${enabled installCExamples}"
  #   "-DINSTALL_PYTHON_EXAMPLES=${enabled installPythonExamples}"
  #   "-DBUILD_EXAMPLES=${enabled buildExamples}"
  # ] ++ stdenv.lib.optionals enableContrib [ "-DOPENCV_EXTRA_MODULES_PATH=${contribSrc}/modules" ];

  enableParallelBuilding = true;

  meta = {
    description = "Automatic Panorama Stitching From Scratch";
    homepage = https://github.com/ppwwyyxx/OpenPano;
    license = stdenv.lib.licenses.mit;
    maintainers = with stdenv.lib.maintainers; [];
  };
}
