# Warning: use the same CUDA version as pytorch-bin.
#
# Precompiled wheels can be found at:
# https://download.pytorch.org/whl/nightly/torch

# To add a new version, run "prefetch.sh 'new-version' 'date'" to paste the generated file as follows.

{ version, date }: builtins.getAttr date (builtins.getAttr version {
  "1.12.0" = {
    "20220420" = {
      x86_64-linux-37 = {
        name = "torch-1.12.0.dev20220420-cp37-cp37m-linux_x86_64.whl";
        url = "https://download.pytorch.org/whl/nightly/cu113/torch-1.12.0.dev20220420%2Bcu113-cp37-cp37m-linux_x86_64.whl";
        hash = "sha256-vBVjSv2CYS/Iiob4ECMVfIO+6WFdvHQ0U6KbRb6rE9s=";
      };
      x86_64-linux-38 = {
        name = "torch-1.12.0.dev20220420-cp38-cp38-linux_x86_64.whl";
        url = "https://download.pytorch.org/whl/nightly/cu113/torch-1.12.0.dev20220420%2Bcu113-cp38-cp38-linux_x86_64.whl";
        hash = "sha256-TSl2TCBxll8a+1cBJkBo2HrcUYI1HsiREeQtlciQFLo=";
      };
      x86_64-linux-39 = {
        name = "torch-1.12.0.dev20220420-cp39-cp39-linux_x86_64.whl";
        url = "https://download.pytorch.org/whl/nightly/cu113/torch-1.12.0.dev20220420%2Bcu113-cp39-cp39-linux_x86_64.whl";
        hash = "sha256-PH/yiQbfT6UtQHtlkUHDcCy1s2gkRDDRceaT6Duwni0=";
      };
      x86_64-linux-310 = {
        name = "torch-1.12.0.dev20220420-cp310-cp310-linux_x86_64.whl";
        url = "https://download.pytorch.org/whl/nightly/cu113/torch-1.12.0.dev20220420%2Bcu113-cp310-cp310-linux_x86_64.whl";
        hash = "sha256-UgeN38v1TI2eW3U8SITKJq4jt6/GZ8c3BB/Xt4GMXao=";
      };
    };
  };
})
