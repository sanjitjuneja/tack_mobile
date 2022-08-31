part of finished_tack_tile;

class FinishedCompleteInfoWidget extends StatelessWidget {
  final DateTime completedAt;

  const FinishedCompleteInfoWidget({
    super.key,
    required this.completedAt,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      FlutterI18n.translate(
        context,
        'previousTacksScreen.completedAt',
        translationParams: <String, String>{
          'completedAt': DateTimeUtility.dateFormatter.format(completedAt),
        },
      ),
      style:
          AppTextTheme.manrope12Regular.copyWith(color: AppTheme.textHintColor),
    );
  }
}
