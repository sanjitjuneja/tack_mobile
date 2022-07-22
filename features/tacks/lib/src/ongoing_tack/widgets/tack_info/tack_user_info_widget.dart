part of 'tack_info_widget.dart';

class TackUserInfoWidget extends StatelessWidget {
  final Tack tack;
  final bool hasDeleteAction;
  final VoidCallback? onDeletePressed;

  const TackUserInfoWidget({
    super.key,
    required this.tack,
    required this.hasDeleteAction,
    this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            tack.tacker.fullName,
            style: AppTextTheme.manrope16Bold
                .copyWith(color: AppTheme.textHeavyHintColor),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (hasDeleteAction) ...<Widget>[
          const SizedBox(width: 6),
          OpacityOnTapContainer(
            onTap: onDeletePressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 2.0,
              ),
              child: AppIconsTheme.more(),
            ),
          ),
          const SizedBox(width: 6),
        ],
      ],
    );
  }
}
