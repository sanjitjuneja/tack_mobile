part of errors;

abstract class LayerErrorHandler {
  const LayerErrorHandler();

  Never proceedError(AppException exception);
}
