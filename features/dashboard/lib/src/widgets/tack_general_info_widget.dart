part of tack_tile;

class TackGeneralInfoWidget extends StatelessWidget {
  final Tack tack;

  const TackGeneralInfoWidget({
    super.key,
    required this.tack,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Text(
            tack.tacker.fullName,
            style: AppTextTheme.manrope16Bold
                .copyWith(color: AppTheme.textHeavyHintColor),
          ),
        ),
        if (tack.estimatedTime != null) ...<Widget>[
          Text(
            DurationUtility.durationFormatString(
              tack.estimatedTime!,
              context,
            ),
            style: AppTextTheme.manrope16Bold
                .copyWith(color: AppTheme.textHeavyHintColor),
          ),
        ],
      ],
    );
  }
}
