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
      children: <Widget>[
        Expanded(
          child: Text(
            tack.tacker.fullName,
            style: AppTextTheme.manrope16Bold
                .copyWith(color: AppTheme.textHeavyHintColor),
          ),
        ),
        Text(
          // TODO: update logic.
          FlutterI18n.translate(
            context,
            'time.minuteShort',
            translationParams: <String, String>{
              'count': tack.estimatedTime.inMinutes.toString(),
            },
          ),
          style: AppTextTheme.manrope16Bold
              .copyWith(color: AppTheme.textHeavyHintColor),
        ),
      ],
    );
  }
}
