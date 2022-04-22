# Warning: use the same CUDA version as pytorch-bin.
#
# Precompiled wheels can be found at:
# https://download.pytorch.org/whl/nightly/torchaudio

# To add a new version, run "prefetch.sh 'new-version' 'date'" to paste the generated file as follows.

{ version, date }: builtins.getAttr date (builtins.getAttr version {
  "0.12.0" = {
    "20220420" = {
      x86_64-linux-37 = {
        name = "torchaudio-0.12.0.dev20220420-cp37-cp37m-linux_x86_64.whl";
        url = "https://download.pytorch.org/whl/nightly/cu113/torchaudio-0.12.0.dev20220420%2Bcu113-cp37-cp37m-linux_x86_64.whl";
        hash = "sha256-xhjuccCCrEzaqr6s7paAHlllOwnQNYzGIf/X/d/4/7U=";
      };
      x86_64-linux-38 = {
        name = "torchaudio-0.12.0.dev20220420-cp38-cp38-linux_x86_64.whl";
        url = "https://download.pytorch.org/whl/nightly/cu113/torchaudio-0.12.0.dev20220420%2Bcu113-cp38-cp38-linux_x86_64.whl";
        hash = "sha256-OQBhg45cfhnjUBvTaViZRvlyKoPOJD51g/yV3ikLkHI=";
      };
      x86_64-linux-39 = {
        name = "torchaudio-0.12.0.dev20220420-cp39-cp39-linux_x86_64.whl";
        url = "https://download.pytorch.org/whl/nightly/cu113/torchaudio-0.12.0.dev20220420%2Bcu113-cp39-cp39-linux_x86_64.whl";
        hash = "sha256-XREVwFADRHvn/cWaHHrEjiUcyoeCIV/nud78cIpcYCk=";
      };
      x86_64-linux-310 = {
        name = "torchaudio-0.12.0.dev20220420-cp310-cp310-linux_x86_64.whl";
        url = "https://download.pytorch.org/whl/nightly/cu113/torchaudio-0.12.0.dev20220420%2Bcu113-cp310-cp310-linux_x86_64.whl";
        hash = "sha256-VCn9CpVQURKJUsQwVIvyYJQMUPiIWZpRQ58OcUrOQUU=";
      };
      x86_64-darwin-37 = {
        name = "torchaudio-0.12.0.dev20220420-cp37-cp37m-macosx_10_15_x86_64.whl";
        url = "https://download.pytorch.org/whl/nightly/torchaudio-0.12.0.dev20220420-cp37-cp37m-macosx_10_15_x86_64.whl";
        hash = "sha256-cC0CYRhOwNorRrLJnskjILRqin57VSdqrjixtYn70us=";
      };
      x86_64-darwin-38 = {
        name = "torchaudio-0.12.0.dev20220420-cp38-cp38-macosx_10_15_x86_64.whl";
        url = "https://download.pytorch.org/whl/nightly/torchaudio-0.12.0.dev20220420-cp38-cp38-macosx_10_15_x86_64.whl";
        hash = "sha256-J37//QUnfUAAC0SsBhkEAXdxQFYNLf05OMB9haUCZ+U=";
      };
      x86_64-darwin-39 = {
        name = "torchaudio-0.12.0.dev20220420-cp39-cp39-macosx_10_15_x86_64.whl";
        url = "https://download.pytorch.org/whl/nightly/torchaudio-0.12.0.dev20220420-cp39-cp39-macosx_10_15_x86_64.whl";
        hash = "sha256-8zfkYAT2OD2C6I0hCBXfqpXiszGF55XfpxtO1adhDC4=";
      };
      x86_64-darwin-310 = {
        name = "torchaudio-0.12.0.dev20220420-cp310-cp310-macosx_10_15_x86_64.whl";
        url = "https://download.pytorch.org/whl/nightly/torchaudio-0.12.0.dev20220420-cp310-cp310-macosx_10_15_x86_64.whl";
        hash = "sha256-X0K2K4zsaUNaX63MQmMFf/kd+WvdZZJmpAImRL5ljpA=";
      };
    };
    "20220422" = {
      x86_64-linux-37 = {
        name = "torchaudio-0.12.0.dev20220422-cp37-cp37m-linux_x86_64.whl";
        url = "https://download.pytorch.org/whl/nightly/cu113/torchaudio-0.12.0.dev20220422%2Bcu113-cp37-cp37m-linux_x86_64.whl";
        hash = "sha256-L0aixXqlZ43ag5XSeoMB8q4kJ58x9RVCJwbhAKWhkwM=";
      };
      x86_64-linux-38 = {
        name = "torchaudio-0.12.0.dev20220422-cp38-cp38-linux_x86_64.whl";
        url = "https://download.pytorch.org/whl/nightly/cu113/torchaudio-0.12.0.dev20220422%2Bcu113-cp38-cp38-linux_x86_64.whl";
        hash = "sha256-ai3pQvGxP+4d417sFbCIut3UEsbsGT5ZCFc/jiXEsw4=";
      };
      x86_64-linux-39 = {
        name = "torchaudio-0.12.0.dev20220422-cp39-cp39-linux_x86_64.whl";
        url = "https://download.pytorch.org/whl/nightly/cu113/torchaudio-0.12.0.dev20220422%2Bcu113-cp39-cp39-linux_x86_64.whl";
        hash = "sha256-aBoN1eJeXwQ9TSd2dgXbKc5icR+PPFU/yHI6QLSjDIY=";
      };
      x86_64-linux-310 = {
        name = "torchaudio-0.12.0.dev20220422-cp310-cp310-linux_x86_64.whl";
        url = "https://download.pytorch.org/whl/nightly/cu113/torchaudio-0.12.0.dev20220422%2Bcu113-cp310-cp310-linux_x86_64.whl";
        hash = "sha256-v2gMNOgXZSqrwypdd8DbGh/6H0TUq/9djzFnFng/MpQ=";
      };
      x86_64-darwin-37 = {
        name = "torchaudio-0.12.0.dev20220422-cp37-cp37m-macosx_10_15_x86_64.whl";
        url = "https://download.pytorch.org/whl/nightly/torchaudio-0.12.0.dev20220422-cp37-cp37m-macosx_10_15_x86_64.whl";
        hash = "sha256-i0It3+yM7kcw+cTD7Ef3rMsX+i2DohaBQHb80D/LT8o=";
      };
      x86_64-darwin-38 = {
        name = "torchaudio-0.12.0.dev20220422-cp38-cp38-macosx_10_15_x86_64.whl";
        url = "https://download.pytorch.org/whl/nightly/torchaudio-0.12.0.dev20220422-cp38-cp38-macosx_10_15_x86_64.whl";
        hash = "sha256-gFm/N7Jka6fZsseEG3Q5ss4KAx1Rlft7JR96CCosqtE=";
      };
      x86_64-darwin-39 = {
        name = "torchaudio-0.12.0.dev20220422-cp39-cp39-macosx_10_15_x86_64.whl";
        url = "https://download.pytorch.org/whl/nightly/torchaudio-0.12.0.dev20220422-cp39-cp39-macosx_10_15_x86_64.whl";
        hash = "sha256-a6yOctMF3kH3iD50uCk7embaffgxq27yyHlPVVUv93s=";
      };
      x86_64-darwin-310 = {
        name = "torchaudio-0.12.0.dev20220422-cp310-cp310-macosx_10_15_x86_64.whl";
        url = "https://download.pytorch.org/whl/nightly/torchaudio-0.12.0.dev20220422-cp310-cp310-macosx_10_15_x86_64.whl";
        hash = "sha256-Jd2dvCGvY5jGLa3n05wvwrdckEdm8QoWp8rvCyjxm0o=";
      };
    };
  };
})
