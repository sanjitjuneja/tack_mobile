import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

extension RunnerTackStatusToDescriptionExtension on Tack {
  static String finalDescription(Tack tack) {
    switch (tack.status) {
      case TackStatus.pendingAccept:
        return tack.group.name;
      default:
        return tack.tacker.fullName;
    }
  }
}

extension RunnerTackStatusToTextStyleExtension on Tack {
  static TextStyle descriptionTextStyle(Tack tack) {
    return AppTextTheme.manrope16Bold
        .copyWith(color: AppTheme.textHeavyHintColor);
  }
}
