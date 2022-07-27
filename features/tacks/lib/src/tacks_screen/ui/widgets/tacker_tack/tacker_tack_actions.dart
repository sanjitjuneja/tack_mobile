import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

class TackerTackActions extends StatelessWidget {
  final Tack tack;

  const TackerTackActions({
    super.key,
    required this.tack,
  });

  @override
  Widget build(BuildContext context) {
    switch (tack.status) {
      case TackStatus.created:
        return AppButton(
          labelKey: 'general.track',
        );
      case TackStatus.pendingAccept:
        return AppButton(
          labelKey: 'tacksScreen.chooseRunnerButton',
          icon: AppIconsTheme.person,
        );
      case TackStatus.pendingStart:
        return AppButton(
          labelKey: 'general.track',
        );
      case TackStatus.inProgress:
        return AppButton(
          labelKey: 'general.track',
        );
      case TackStatus.pendingReview:
        return AppButton(
          labelKey: 'general.review',
          icon: AppIconsTheme.edit,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
