import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

class TackerTackActions extends StatelessWidget {
  final Tack tack;
  final VoidCallback onTap;

  const TackerTackActions({
    super.key,
    required this.tack,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final String labelKey;
    final AppIcon? icon;

    switch (tack.status) {
      case TackStatus.created:
        labelKey = 'general.track';
        icon = null;
        break;
      case TackStatus.pendingAccept:
        labelKey = 'tacksScreen.chooseRunnerButton';
        icon = AppIconsTheme.person;
        break;
      case TackStatus.pendingStart:
        labelKey = 'general.track';
        icon = null;
        break;
      case TackStatus.inProgress:
        labelKey = 'general.track';
        icon = null;
        break;
      case TackStatus.pendingReview:
        labelKey = 'general.review';
        icon = AppIconsTheme.edit;
        break;

      default:
        return const SizedBox.shrink();
    }

    return Row(
      children: <Widget>[
        AppCircleAvatarWidget(tack.group.imageUrl),
        const SizedBox(width: 10),
        Expanded(
          child: AppButton(
            labelKey: labelKey,
            icon: icon,
            onTap: onTap,
          ),
        ),
      ],
    );
  }
}
