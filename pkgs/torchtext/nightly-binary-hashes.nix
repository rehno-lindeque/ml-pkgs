# Precompiled wheels can be found at:
# https://download.pytorch.org/whl/nightly/torchtext

# To add a new version, run "prefetch.sh 'new-version' 'date'" to paste the generated file as follows.

{ version, date }: builtins.getAttr date (builtins.getAttr version {
  "0.13.0" = {
    "20220420" = {
      x86_64-linux-37 = {
        name = "torchtext-0.13.0.dev20220420-cp37-cp37m-linux_x86_64.whl";
        url = "https://download.pytorch.org/whl/nightly/torchtext-0.13.0.dev20220420-cp37-cp37m-linux_x86_64.whl";
        hash = "sha256-sN1LfDyomxNLNr/9xOYP1XFV909dKF/QCf/OZCdjKsY=";
      };
      x86_64-linux-38 = {
        name = "torchtext-0.13.0.dev20220420-cp38-cp38-linux_x86_64.whl";
        url = "https://download.pytorch.org/whl/nightly/torchtext-0.13.0.dev20220420-cp38-cp38-linux_x86_64.whl";
        hash = "sha256-4wCnOgfeOC3TUZRcfxFNTgm7VWkCV7DHhDlCaBt+t3w=";
      };
      x86_64-linux-39 = {
        name = "torchtext-0.13.0.dev20220420-cp39-cp39-linux_x86_64.whl";
        url = "https://download.pytorch.org/whl/nightly/torchtext-0.13.0.dev20220420-cp39-cp39-linux_x86_64.whl";
        hash = "sha256-5+5gkUSUSNRjAbblUYsj9RAGHVKGW8eYTSTaMo+s64E=";
      };
      x86_64-linux-310 = {
        name = "torchtext-0.13.0.dev20220420-cp310-cp310-linux_x86_64.whl";
        url = "https://download.pytorch.org/whl/nightly/torchtext-0.13.0.dev20220420-cp310-cp310-linux_x86_64.whl";
        hash = "sha256-dEtvAQ9pJ5ZFFVMvCGKptONj4VFHolUtkq9cKBatWkQ=";
      };
      x86_64-darwin-37 = {
        name = "torchtext-0.13.0.dev20220420-cp37-cp37m-macosx_10_9_x86_64.whl";
        url = "https://download.pytorch.org/whl/nightly/torchtext-0.13.0.dev20220420-cp37-cp37m-macosx_10_9_x86_64.whl";
        hash = "sha256-3YOIlUIeYBm3Hmy+byCkY26ryvvs9/RPGPN7KZWMbEU=";
      };
      x86_64-darwin-38 = {
        name = "torchtext-0.13.0.dev20220420-cp38-cp38-macosx_10_9_x86_64.whl";
        url = "https://download.pytorch.org/whl/nightly/torchtext-0.13.0.dev20220420-cp38-cp38-macosx_10_9_x86_64.whl";
        hash = "sha256-kTPQhxs9qqMGD4Y6jFoEN/vjxGfR0LKB8DkBRzaKJh8=";
      };
      x86_64-darwin-39 = {
        name = "torchtext-0.13.0.dev20220420-cp39-cp39-macosx_10_9_x86_64.whl";
        url = "https://download.pytorch.org/whl/nightly/torchtext-0.13.0.dev20220420-cp39-cp39-macosx_10_9_x86_64.whl";
        hash = "sha256-ck3A901V11MwCCqygyNn9wqWxET/Dsg2sQGfEqVnja4=";
      };
      x86_64-darwin-310 = {
        name = "torchtext-0.13.0.dev20220420-cp310-cp310-macosx_10_9_x86_64.whl";
        url = "https://download.pytorch.org/whl/nightly/torchtext-0.13.0.dev20220420-cp310-cp310-macosx_10_9_x86_64.whl";
        hash = "sha256-yK07X6YPRMw+vqQa0ps+tRxuQCQ4QCLOM4J5DyolZcc=";
      };
    };
  };
})
