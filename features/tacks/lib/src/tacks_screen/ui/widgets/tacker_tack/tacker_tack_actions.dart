import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

class TackerTackActions extends StatelessWidget {
  final TackerTack tack;

  const TackerTackActions({
    super.key,
    required this.tack,
  });

  @override
  Widget build(BuildContext context) {
    switch (tack.status) {
      case TackerTackStatus.created:
        return AppButton(
          labelKey: 'general.track',
        );
      case TackerTackStatus.pendingChoose:
        return AppButton(
          labelKey: 'tacksScreen.chooseRunnerButton',
          icon: AppIconsTheme.person,
        );
      case TackerTackStatus.inProgress:
        return AppButton(
          labelKey: 'general.track',
        );
      case TackerTackStatus.pendingReview:
        return AppButton(
          labelKey: 'general.review',
          icon: AppIconsTheme.edit,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
