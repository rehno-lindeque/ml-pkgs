{ lib
, stdenv
, fetchurl
, isPy3k
, buildPythonPackage
, python
, pytorch
}:

let
  version = "0.4.0";
  date = "20220420";
in buildPythonPackage {
  version = "${version}-${date}";

  pname = "torchdata";

  format = "wheel";

  disabled = !isPy3k;

  src = fetchurl {
    name = "torchdata-${version}.dev${date}-py3-none-any.whl";
    url = "https://download.pytorch.org/whl/nightly/torchdata-${version}.dev${date}-py3-none-any.whl";
    hash = "sha256:01d9q324n3kz6gi26yhvjr1adjhdwalkrwj3ycg7w31idcrr6nnz";
  };

  # nativeBuildInputs = [
  #   patchelf
  # ];

  propagatedBuildInputs = [
    pytorch
  ];

  # postFixup = let
  #   rpath = lib.makeLibraryPath [ stdenv.cc.cc.lib ];
  # in ''
  #   find $out/${python.sitePackages}/torch/lib -type f \( -name '*.so' -or -name '*.so.*' \) | while read lib; do
  #     echo "setting rpath for $lib..."
  #     patchelf --set-rpath "${rpath}:$out/${python.sitePackages}/torch/lib" "$lib"
  #   done
  # '';

  # The wheel-binary is not stripped to avoid the error of `ImportError: libtorch_cuda_cpp.so: ELF load command address/offset not properly aligned.`.
  # dontStrip = true;

  pythonImportsCheck = [ "torchdata.datapipes" ];

  meta = with lib; {
    description = "Open source, prototype-to-production deep learning platform";
    homepage = "https://pytorch.org/";
    license = licenses.bsd3;
    platforms = platforms.linux ++ platforms.darwin;
    maintainers = with maintainers; [];
  };
}
