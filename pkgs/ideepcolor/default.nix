{
  pkgs ? import <nixpkgs> {},
  python,
  pythonPackages,
  opencv3,
  qdarkstyle,
}:
# let
#   qdarkstyle =
#     pkgs.callPackage ../qdarkstyle/default.nix {
#       python = pkgs.python2;
#       pythonPackages = pkgs.python2Packages;
#     };
# in
# used for creating annotations
pythonPackages.buildPythonApplication rec {
  version = "dev";
  name = "ideepcolor-${version}";
  src = pkgs.fetchFromGitHub {
    owner = "junyanz";
    repo = "interactive-deep-colorization";
    rev = "f26141a30b34f76eb82e4f93c102156dc548fc3b";
    sha256 = "1bsplq11d6z37h923mxy21b8g8nxz09wnrm42v9hxz1qpdrcvdcr";
  };
  propagatedBuildInputs =
    (with pythonPackages; [
      (caffe.override {
        cudaSupport = true;
        cudatoolkit = pkgs.cudatoolkit.overrideAttrs (oldAttrs: rec {
          version = "9.0.176";
          name = "cudatoolkit-${version}";
          url = "https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda_${version}_384.81_linux-run";
          sha256 = "0308rmmychxfa4inb1ird9bpgfppgr9yrfg1qp0val5azqik91ln";
        });
        # cudatoolkit = pkgs.cudatoolkit.overrideAttrs (oldAttrs: rec {
        #     version = "9.1.85";
        #     name = "cudatoolkit-${version}";
        #     src = pkgs.fetchurl {
        #       # url = "https://developer.nvidia.com/compute/cuda/9.1/Prod/local_installers/cuda_${version}_linux-run";
        #       url = "https://developer.nvidia.com/compute/cuda/9.1/Prod/local_installers/cuda_${version}_387.26_linux";
        #       sha256 = "0lz9bwhck1ax4xf1fyb5nicb7l1kssslj518z64iirpy2qmwg5l4";
        #     };
        #     # gcc = gcc6;
        #     unpackPhase = ''
        #       sh $src --keep --noexec
        #       cd pkg/run_files
        #       ls cuda-linux*.run
        #       ls cuda-samples*.run
        #       # cat cuda-linux.9.1.85-23083092.run
        #       sh cuda-linux*.run
        #       # sh cuda-samples*.run
        #       # cd pkg
        #     '';
        #   });
      })
      scikitimage
      scikitlearn
      qdarkstyle
      pyqt4
      opencv3
    ])
    ++ [
      python
    ];
  # propagatedBuildInputs = [ python ];

  installPhase = ''
    mkdir -p $out/bin
    install -m 0755 *.py $out/bin
    chmod +x $out/bin/*.py
    # for f in $out/bin/*.py; do
    #   substituteInPlace "$f" \
    #     --replace 'import Image' 'from PIL import Image'
    # done
    wrapPythonPrograms
  '';
}
