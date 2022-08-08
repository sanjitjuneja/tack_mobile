import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

extension TackerTackStatusToDescriptionExtension on Tack {
  static String finalDescription(Tack tack) {
    switch (tack.status) {
      case TackStatus.created:
        return 'tacksScreen.tackerStatus.created';
      case TackStatus.pendingAccept:
        return 'tacksScreen.tackerStatus.accepted';
      default:
        return tack.runner?.fullName ?? '';
    }
  }
}

extension TackerTackStatusToTextStyleExtension on Tack {
  static TextStyle descriptionTextStyle(Tack tack) {
    return AppTextTheme.manrope16Bold
        .copyWith(color: AppTheme.textHeavyHintColor);
  }
}
