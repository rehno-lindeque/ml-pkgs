# Warning: use the same CUDA version as pytorch-bin.
#
# Precompiled wheels can be found at:
# https://download.pytorch.org/whl/nightly/torchvision

# To add a new version, run "prefetch.sh 'new-version' 'date'" to paste the generated file as follows.

{ version, date }: builtins.getAttr date (builtins.getAttr version {
  "0.13.0" = {
    "20220420" = {
      x86_64-linux-37 = {
        name = "torchvision-0.13.0.dev20220420-cp37-cp37m-linux_x86_64.whl";
        url = "https://download.pytorch.org/whl/nightly/cu113/torchvision-0.13.0.dev20220420%2Bcu113-cp37-cp37m-linux_x86_64.whl";
        hash = "sha256-b1tj1M3ih+zsUoPyOEeAw8o8xx9JDCeLSkWxJKXRp70=";
      };
      x86_64-linux-38 = {
        name = "torchvision-0.13.0.dev20220420-cp38-cp38-linux_x86_64.whl";
        url = "https://download.pytorch.org/whl/nightly/cu113/torchvision-0.13.0.dev20220420%2Bcu113-cp38-cp38-linux_x86_64.whl";
        hash = "sha256-g1n+BJUM0Hs2IyFmLaYDpBECJU0SMNzqx30NgcVYYac=";
      };
      x86_64-linux-39 = {
        name = "torchvision-0.13.0.dev20220420-cp39-cp39-linux_x86_64.whl";
        url = "https://download.pytorch.org/whl/nightly/cu113/torchvision-0.13.0.dev20220420%2Bcu113-cp39-cp39-linux_x86_64.whl";
        hash = "sha256-o0lson1PHQkTUa/z/bfgboBRkfm6K1I8Zg6znnRM7K0=";
      };
      x86_64-linux-310 = {
        name = "torchvision-0.13.0.dev20220420-cp310-cp310-linux_x86_64.whl";
        url = "https://download.pytorch.org/whl/nightly/cu113/torchvision-0.13.0.dev20220420%2Bcu113-cp310-cp310-linux_x86_64.whl";
        hash = "sha256-cF4MUnxAHkElexgB3+GPUhDkMmx7g40VAEGUV3QECYA=";
      };
      x86_64-darwin-37 = {
        name = "torchvision-0.13.0.dev20220420-cp37-cp37m-macosx_10_9_x86_64.whl";
        url = "https://download.pytorch.org/whl/nightly/torchvision-0.13.0.dev20220420-cp37-cp37m-macosx_10_9_x86_64.whl";
        hash = "sha256-HgEmxuDg05rWG4HXFn3AsOhcJY409wHByw2o1TiBKEo=";
      };
      x86_64-darwin-38 = {
        name = "torchvision-0.13.0.dev20220420-cp38-cp38-macosx_10_9_x86_64.whl";
        url = "https://download.pytorch.org/whl/nightly/torchvision-0.13.0.dev20220420-cp38-cp38-macosx_10_9_x86_64.whl";
        hash = "sha256-ez1LEB5Z1ISoyxDhYFDPzGsqC+auxG3Dn8jPGlaZBLE=";
      };
      x86_64-darwin-39 = {
        name = "torchvision-0.13.0.dev20220420-cp39-cp39-macosx_10_9_x86_64.whl";
        url = "https://download.pytorch.org/whl/nightly/torchvision-0.13.0.dev20220420-cp39-cp39-macosx_10_9_x86_64.whl";
        hash = "sha256-/aeAhCykz72Lxdry6DpyJdvKD+LcMsiIWzVWDLNqkZo=";
      };
      x86_64-darwin-310 = {
        name = "torchvision-0.13.0.dev20220420-cp310-cp310-macosx_10_9_x86_64.whl";
        url = "https://download.pytorch.org/whl/nightly/torchvision-0.13.0.dev20220420-cp310-cp310-macosx_10_9_x86_64.whl";
        hash = "sha256-oLTppmJ66ORawelyWiO+2HKHpPjvMoh6FImXfXhyhvk=";
      };
    };
  };
})
