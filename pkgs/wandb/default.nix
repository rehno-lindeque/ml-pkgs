{
  buildPythonPackage,
  click,
  configparser,
  docker_pycreds,
  fetchFromGitHub,
  git,
  GitPython,
  lib,
  pathtools,
  promise,
  protobuf,
  psutil,
  python,
  python-dateutil,
  pyyaml,
  requests,
  sentry-sdk,
  setuptools,
  shortuuid,
  yaspin,
}:
buildPythonPackage rec {
  pname = "wandb";
  version = "0.12.6";

  src = fetchFromGitHub {
    owner = pname;
    repo = "client";
    rev = "v${version}";
    sha256 = "0prmg3az1yzwn0nmdir7vw6nzpdfmwflyba0yny4x0r4zc4p4jjr";
  };

  # The wandb requirements.txt does not distinguish python2/3 dependencies. We
  # need to drop the subprocess32 dependency when building for python3.
  patchPhase = ''
    substituteInPlace requirements.txt --replace "subprocess32>=3.5.3" ""
  '';

  # git is not a setup.py dependency of wandb, but wandb does expect git to be
  # in PATH. See https://gist.github.com/samuela/57aeee710e41ab2bf361b7ed8fbbeabf
  # for the error message, and an example usage here: https://github.com/wandb/client/blob/master/wandb/sdk/internal/meta.py#L139-L141.
  # setuptools is necessary since pkg_resources is required at runtime.
  propagatedBuildInputs = [
    click
    configparser
    docker_pycreds
    git
    GitPython
    pathtools
    promise
    protobuf
    psutil
    python-dateutil
    pyyaml
    requests
    sentry-sdk
    setuptools
    shortuuid
    yaspin
  ];

  # Test suite is currently broken. See https://github.com/wandb/client/issues/2682.
  doCheck = false;

  pythonImportsCheck = ["wandb"];

  meta = with lib; {
    description = "A CLI and library for interacting with the Weights and Biases API";
    homepage = "https://github.com/wandb/client";
    license = licenses.mit;
    maintainers = with maintainers; [samuela];
  };
}
