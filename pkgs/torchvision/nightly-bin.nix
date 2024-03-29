{ lib
, stdenv
, buildPythonPackage
, fetchurl
, isPy37
, isPy38
, isPy39
, isPy310
, patchelf
, pillow
, python
, pytorch
}:

let
  pyVerNoDot = builtins.replaceStrings [ "." ] [ "" ] python.pythonVersion;
  version = "0.13.0";
  date = "20220420";
  srcs = import ./nightly-binary-hashes.nix { inherit version date; };
  unsupported = throw "Unsupported system";
in buildPythonPackage {
  version = "${version}-${date}";

  pname = "torchvision";

  format = "wheel";

  src = fetchurl srcs."${stdenv.system}-${pyVerNoDot}" or unsupported;

  disabled = !(isPy37 || isPy38 || isPy39 || isPy310);

  nativeBuildInputs = [
    patchelf
  ];

  propagatedBuildInputs = [
    pillow
    pytorch
  ];

  # The wheel-binary is not stripped to avoid the error of `ImportError: libtorch_cuda_cpp.so: ELF load command address/offset not properly aligned.`.
  dontStrip = true;

  pythonImportsCheck = [ "torchvision" ];

  postFixup = let
    rpath = lib.makeLibraryPath [ stdenv.cc.cc.lib ];
  in ''
    # Note: after patchelf'ing, libcudart can still not be found. However, this should
    #       not be an issue, because PyTorch is loaded before torchvision and brings
    #       in the necessary symbols.
    patchelf --set-rpath "${rpath}:${pytorch}/${python.sitePackages}/torch/lib:" \
      "$out/${python.sitePackages}/torchvision/_C.so"
  '';

  meta = with lib; {
    description = "PyTorch vision library";
    homepage = "https://pytorch.org/";
    changelog = "https://github.com/pytorch/vision/releases/tag/v${version}";
    # Includes CUDA and Intel MKL, but redistributions of the binary are not limited.
    # https://docs.nvidia.com/cuda/eula/index.html
    # https://www.intel.com/content/www/us/en/developer/articles/license/onemkl-license-faq.html
    license = licenses.bsd3;
    platforms = platforms.linux;
    maintainers = with maintainers; [];
  };
}
