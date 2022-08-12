import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

class TackBalance extends StatelessWidget {
  final double tackBalance;

  const TackBalance({
    Key? key,
    required this.tackBalance,
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
              const SizedBox(width: 36),
              Text(
                '\$ ${tackBalance.toStringAsFixed(2)}',
                style: AppTextTheme.manrope30Bold.copyWith(
                  color: AppTheme.textSecondaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 48),
          Padding(
            padding: const EdgeInsets.only(left: 56),
            child: IntrinsicHeight(
              child: Row(
                children: <Widget>[
                  Column(
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
                  const SizedBox(width: 28),
                  AppDivider(
                    axis: Axis.vertical,
                    height: 50,
                    color: AppTheme.dividerSecondaryColor,
                  ),
                  const SizedBox(width: 28),
                  Column(
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
