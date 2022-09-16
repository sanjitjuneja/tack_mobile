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
    final String labelKey =
        'tacksScreen.statusButtons.tacker.${tack.status.name}';
    final AppIcon? icon;

    switch (tack.status) {
      case TackStatus.created:
        icon = AppIconsTheme.clock;
        break;
      case TackStatus.pendingAccept:
        icon = AppIconsTheme.person;
        break;
      case TackStatus.pendingStart:
        icon = AppIconsTheme.clock;
        break;
      case TackStatus.inProgress:
        icon = AppIconsTheme.clock;
        break;
      case TackStatus.pendingReview:
        icon = AppIconsTheme.taskComplete;
        break;

      default:
        return const SizedBox.shrink();
    }

    return Row(
      children: <Widget>[
        AppNetworkImageWidget(
          tack.group.imageUrl,
          placeholderIcon: null,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            tack.group.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextTheme.manrope16Bold
                .copyWith(color: AppTheme.textHeavyHintColor),
          ),
        ),
        const SizedBox(width: 6),
        AppButton(
          labelKey: labelKey,
          icon: icon,
          constraints: const BoxConstraints(minWidth: 120),
          expanded: false,
          onTap: onTap,
        ),
      ],
    );
  }
}
