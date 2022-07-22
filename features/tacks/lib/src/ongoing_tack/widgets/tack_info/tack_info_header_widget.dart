part of 'tack_info_widget.dart';

class TackInfoHeaderWidget extends StatelessWidget {
  final Tack tack;

  const TackInfoHeaderWidget({
    super.key,
    required this.tack,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Text(
            tack.title,
            style: AppTextTheme.manrope16SemiBold
                .copyWith(color: AppTheme.textPrimaryColor),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          CurrencyUtility.dollarFormat.format(tack.price),
          style: AppTextTheme.manrope24Bold
              .copyWith(color: AppTheme.textSecondaryColor),
        ),
      ],
    );
  }
}
