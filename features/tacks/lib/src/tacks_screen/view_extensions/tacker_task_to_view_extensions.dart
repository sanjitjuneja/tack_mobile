import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

extension TackerTackStatusToDescriptionExtension on TackerTack {
  String get finalDescription {
    switch (status) {
      case TackerTackStatus.created:
        return 'tacksScreen.tackerStatus.created';
      default:
        return creator.name;
    }
  }
}

extension TackerTackStatusToTextStyleExtension on TackerTack {
  TextStyle get descriptionTextStyle {
    switch (status) {
      case TackerTackStatus.created:
        return AppTextTheme.manrope20Bold
            .copyWith(color: AppTheme.textDisabledColor);
      default:
        return AppTextTheme.manrope16Bold
            .copyWith(color: AppTheme.textHeavyHintColor);
    }
  }
}
