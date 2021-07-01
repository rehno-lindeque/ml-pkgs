self:
super:

let
  cudnn-generic-expr = self.fetchurl {
    # See https://github.com/NixOS/nixpkgs/pull/31551
    url = "https://raw.githubusercontent.com/lukeadams/nixpkgs/737013b49408738e1912ce3723a00d49cd47eeca/pkgs/development/libraries/science/math/cudnn/generic.nix";
    sha256 = "19awq93plcibx3wbfajhr1028lymb9shkni5aqb9kbjb75sksash";
  };

  cudnn-generic = args: self.callPackage (import cudnn-generic-expr.outPath (removeAttrs args ["cudatoolkit"])) {
    inherit (args) cudatoolkit;
  };

in

{
  cudatoolkit9 = super.cudatoolkit9.overrideAttrs (drv: {
      version = "9.1.85.1";
      url = "https://developer.nvidia.com/compute/cuda/9.1/Prod/local_installers/cuda_9.1.85_387.26_linux";
      sha256 = "0lz9bwhck1ax4xf1fyb5nicb7l1kssslj518z64iirpy2qmwg5l4";
      runPatches = [
        (self.fetchurl {
          url = "https://developer.nvidia.com/compute/cuda/9.1/Prod/patches/1/cuda_9.1.85.1_linux";
          sha256 = "1f53ij5nb7g0vb5pcpaqvkaj1x4mfq3l0mhkfnqbk8sfrvby775g";
        })
        (self.fetchurl {
          url = "https://developer.nvidia.com/compute/cuda/9.1/Prod/patches/2/cuda_9.1.85.2_linux";
          sha256 = "16g0w09h3bqmas4hy1m0y6j5ffyharslw52fn25gql57bfihg7ym";
        })
        (self.fetchurl {
          url = "https://developer.nvidia.com/compute/cuda/9.1/Prod/patches/3/cuda_9.1.85.3_linux";
          sha256 = "12mcv6f8z33z8y41ja8bv5p5iqhv2vx91mv3b5z6fcj7iqv98422";
        })
      ];
      gcc = self.gcc7;
      # cc = self.gcc7; (Todo: requires rebuild)
    });

  cudnn7 = cudnn-generic rec {
    version = "7.0.5";
    # cudatoolkit = self.cudatoolkit7;
    # cudatoolkit = self.cudatoolkit75;
    cudatoolkit = self.cudatoolkit9;
    srcName = "cudnn-${self.cudatoolkit.majorVersion}-linux-x64-v7.tgz";
    sha256 = "1rfmdd2v47p83fm3sfyvik31gci0q17qs6kjng6mvcsd6akmvb8y";
  };

  cudnn71 = cudnn-generic rec {
    version = "7.1.3";
    cudatoolkit = self.cudatoolkit9;
    # srcName = "cudnn-${self.cudatoolkit.majorVersion}-linux-x64-v7.tgz";
    srcName = "cudnn-9.0-linux-x64-v7.1.tgz";
    sha256 = "0sd3hdmnxvgqkvvnp7ir9djm9hmxk77vpn2hsmwzd5jvrh01ffi0";
  };

  # opencv3 = super.opencv3.override {
  #   cudatoolkit = self.cudnn71.cudatoolkit;
  #   enableCuda = true;
  # };
  # opencv3 = (super.opencv3.override {
  #     cudatoolkit = self.cudnn71.cudatoolkit // { cc = self.gcc7; };
  #     # enableCuda = true;
  #   }).overrideAttrs (drv: {
  #     cmakeFlags = drv.cmakeFlags ++ [ "-DBUILD_opencv_dnn_modern=OFF" ];
  #   });
  opencv3 = super.opencv3.overrideAttrs (drv: {
      cmakeFlags = drv.cmakeFlags ++ [ "-DBUILD_opencv_dnn_modern=OFF" ];
    });

  # python3Packages = super.python3Packages.override {
  python3 = super.python3.override {
    packageOverrides = pythonSelf: pythonSuper: {
      # opencv3 = (pythonSuper.opencv3.override {
      #     cudatoolkit = self.cudnn71.cudatoolkit;
      #     enableCuda = true;
      #   }).overrideAttrs (drv: {
      #     cmakeFlags = drv.cmakeFlags ++ [ "-DBUILD_opencv_dnn_modern=OFF" ];
      #   });
      tensorflow = pythonSuper.tensorflow.override {
        # Enable / disable these as required:
        cudaSupport = true;
        # nvidia_x11 = null;
        # cudatoolkit = null;
        nvidia_x11 = self.linuxPackages.nvidia_x11;
        # nvidia_x11 = self.linuxPackages.nvidia_x11.override { libsOnly = true; };
        # cudnn = self.cudnn71;
        # cudaCapabilities = [ "3.5" "5.2" ];
        sse42Support = true;
        avx2Support = true;
        fmaSupport = true;
      };
    };
  };
}
