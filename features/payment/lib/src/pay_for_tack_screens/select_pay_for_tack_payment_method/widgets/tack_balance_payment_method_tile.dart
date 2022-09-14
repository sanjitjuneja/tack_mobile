import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

class TackBalancePaymentMethodTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isSelected;

  const TackBalancePaymentMethodTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.textFieldSecondaryBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                AppIconsTheme.tack(size: 35),
                const SizedBox(width: 26.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: AppTextTheme.poppins18Medium,
                    ),
                    Text(
                      subtitle,
                      style: AppTextTheme.poppins12Medium.copyWith(
                        color: AppColors.shuttleGray,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                if (isSelected) ...<Widget>[
                  AppIconsTheme.checkMarkFilled(size: 30),
                ],
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
