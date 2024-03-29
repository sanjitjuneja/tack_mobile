import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

class TackBalance extends StatelessWidget {
  final double tackBalance;
  final VoidCallback onAddCashTap;
  final VoidCallback onPayoutTap;

  const TackBalance({
    Key? key,
    required this.tackBalance,
    required this.onAddCashTap,
    required this.onPayoutTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppTheme.textFieldSecondaryBackgroundColor,
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: AppColors.black25,
            offset: Offset(0.0, 4.0),
            spreadRadius: 0.0,
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              AppIconsTheme.tack(size: 32),
              const SizedBox(width: 8),
              Text(
                FlutterI18n.translate(
                  context,
                  'paymentSettingsScreen.tackBalance',
                ),
                style: AppTextTheme.poppins18Medium,
              ),
              const Spacer(),
              Expanded(
                flex: 4,
                child: Text(
                  CurrencyUtility.dollarFormat.format(tackBalance),
                  style: AppTextTheme.manrope30Bold.copyWith(
                    color: AppTheme.textSecondaryColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 48),
          IntrinsicHeight(
            child: Row(
              children: <Widget>[
                const Spacer(),
                GestureDetector(
                  onTap: onAddCashTap,
                  child: Column(
                    children: <Widget>[
                      AppIconsTheme.add.svg(size: 32),
                      const SizedBox(height: 4),
                      Text(
                        FlutterI18n.translate(
                          context,
                          'paymentSettingsScreen.addCash',
                        ),
                        style: AppTextTheme.poppins14Medium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 28),
                AppDivider(
                  axis: Axis.vertical,
                  height: 50,
                  color: AppTheme.dividerSecondaryColor,
                ),
                const SizedBox(width: 28),
                GestureDetector(
                  onTap: onPayoutTap,
                  child: Column(
                    children: <Widget>[
                      AppIconsTheme.bankRounded.svg(size: 32),
                      const SizedBox(height: 4),
                      Text(
                        FlutterI18n.translate(
                          context,
                          'paymentSettingsScreen.payout',
                        ),
                        style: AppTextTheme.poppins14Medium,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
