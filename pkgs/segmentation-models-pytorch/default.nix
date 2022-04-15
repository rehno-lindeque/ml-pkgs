{
  buildPythonPackage,
  fetchPypi,
  lib,
  torchvision,
  efficientnet-pytorch,
  timm,
}:
buildPythonPackage rec {
  version = "0.1.3";
  pname = "segmentation_models_pytorch";

  format = "wheel";

  src = fetchPypi {
    inherit pname version;
    format = "wheel";
    python = "py3";
    sha256 = "1s0mx1bsbg51v02fy6x72nif20c5zh76zs35v9gb9vzjp32c8nry";
  };

  # postPatch = ''
  #   model_zoo.load_url
  #       encoder.load_state_dict(model_zoo.load_url(settings["url"]))
  #  substituteInPlace "" \
  #      --replace 'model_zoo.load_url(settings["url"])' ''
  # '';

  propagatedBuildInputs = [torchvision efficientnet-pytorch timm];

  meta = {
    description = "Image segmentation models with pre-trained backbones. PyTorch.";
    homepage = "https://github.com/qubvel/segmentation_models.pytorch";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [];
  };
}
