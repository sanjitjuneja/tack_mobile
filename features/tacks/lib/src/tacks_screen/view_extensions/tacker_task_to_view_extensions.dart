import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

extension TackerTackStatusToDescriptionExtension on Tack {
  String get finalDescription {
    switch (status) {
      case TackStatus.created:
        return 'tacksScreen.tackerStatus.created';
      default:
        return tacker.fullName;
    }
  }
}

extension TackerTackStatusToTextStyleExtension on Tack {
  TextStyle get descriptionTextStyle {
    switch (status) {
      case TackStatus.created:
        return AppTextTheme.manrope20Bold
            .copyWith(color: AppTheme.textDisabledColor);
      default:
        return AppTextTheme.manrope16Bold
            .copyWith(color: AppTheme.textHeavyHintColor);
    }
  }
}
