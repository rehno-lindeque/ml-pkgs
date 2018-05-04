self:
super:

{
  python3Packages = super.python3Packages.override {
    overrides = self: super: {
      tensorflow = super.tensorflow.override {
        # Enable / disable these as required:
        # cudaSupport = true;
        # nvidia_x11 = null;
        # cudatoolkit = null;
        # cudnn = null;
        # cudaCapabilities = [ "3.5" "5.2" ];
        sse42Support = true;
        avx2Support = true;
        fmaSupport = true;
      };
    };
  };
}
