part of app_dialog;

extension AlertImage on Alert {
  Image get image {
    if (this is SuccessAlert) {
      return AppImagesTheme.alertSuccess;
    } else if (this is RequestAlert) {
      return AppImagesTheme.alertRequest;
    } else if (this is ErrorAlert) {
      return AppImagesTheme.alertError;
    } else if (this is DestructiveAlert) {
      return AppImagesTheme.alertError;
    } else {
      throw ArgumentError('not supported argument');
    }
  }

  Color get color {
    if (this is SuccessAlert) {
      return AppTheme.successColor;
    } else if (this is RequestAlert) {
      return AppTheme.successColor;
    } else if (this is ErrorAlert) {
      return AppTheme.errorColor;
    } else if (this is DestructiveAlert) {
      return AppTheme.errorColor;
    }else {
      throw ArgumentError('not supported argument');
    }
  }
}
