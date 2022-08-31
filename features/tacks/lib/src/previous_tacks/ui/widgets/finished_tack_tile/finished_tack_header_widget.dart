part of finished_tack_tile;

class FinishedTackHeaderWidget extends StatelessWidget {
  final String name;
  final double price;

  const FinishedTackHeaderWidget({
    super.key,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Text(
              name,
              style: AppTextTheme.manrope16SemiBold
                  .copyWith(color: AppTheme.textPrimaryColor),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          CurrencyUtility.dollarFormat.format(price),
          style: AppTextTheme.manrope24Bold
              .copyWith(color: AppTheme.textSecondaryColor),
        ),
      ],
    );
  }
}
