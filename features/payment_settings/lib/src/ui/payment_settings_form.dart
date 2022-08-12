import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import '/src/widgets/payment_method_tile.dart';

class PaymentSettingsForm extends StatelessWidget {
  const PaymentSettingsForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Text(
              FlutterI18n.translate(
                context,
                'paymentSettingsScreen.title',
              ),
              style: AppTextTheme.manrope24SemiBold,
            ),
          ),
          const SizedBox(height: 25),
          _tackBalance(
            context: context,
            tackBalance: 0.00,
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 17.0),
            child: Text(
              FlutterI18n.translate(
                context,
                'paymentSettingsScreen.banks',
              ),
              style: AppTextTheme.manrope20Bold,
            ),
          ),
          const SizedBox(height: 14),
          PaymentMethodTile(
            leadingIcon: AppIconsTheme.masterCard,
            title: 'JP Morgan Chase',
            subtitle: '*****8748',
            isPrimary: true,
          ),
          PaymentMethodTile(
            leadingIcon: AppIconsTheme.masterCard,
            title: 'JP Morgan Chase',
            subtitle: '*****8748',
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 17.0),
            child: Text(
              FlutterI18n.translate(
                context,
                'paymentSettingsScreen.cards',
              ),
              style: AppTextTheme.manrope20Bold,
            ),
          ),
          const SizedBox(height: 14),
          PaymentMethodTile(
            leadingIcon: AppIconsTheme.masterCard,
            title: 'Mastercard',
            subtitle: '*****4685',
          ),
          PaymentMethodTile(
            leadingIcon: AppIconsTheme.masterCard,
            title: 'JP Morgan Chase',
            subtitle: '*****6448',
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 17.0),
            child: Text(
              FlutterI18n.translate(
                context,
                'paymentSettingsScreen.digitalWallets',
              ),
              style: AppTextTheme.manrope20Bold,
            ),
          ),
          const SizedBox(height: 14),
          PaymentMethodTile(
            leadingIcon: AppIconsTheme.applePay,
            title: 'Apple Pay',
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 17.0),
            child: Text(
              FlutterI18n.translate(
                context,
                'paymentSettingsScreen.add',
              ),
              style: AppTextTheme.manrope20Bold,
            ),
          ),
          const SizedBox(height: 14),
          PaymentMethodTile(
            leadingIcon: AppIconsTheme.bank,
            title: FlutterI18n.translate(
              context,
              'paymentSettingsScreen.addPaymentMethod',
            ),
          ),
          const SizedBox(height: 28),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              children: <Widget>[
                AppIconsTheme.lock.svg(size: 15),
                const SizedBox(width: 5),
                Text(
                  FlutterI18n.translate(
                    context,
                    'paymentSettingsScreen.privacyInfo',
                  ),
                  style: AppTextTheme.manrope13Medium.copyWith(
                    color: AppTheme.textSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 34),
        ],
      ),
    );
  }

  Widget _tackBalance({
    required BuildContext context,
    required double tackBalance,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13),
      child: Container(
        width: 348,
        height: 181,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppTheme.textFieldSecondaryBackgroundColor,
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: AppColors.black25,
              offset: Offset(0.0, 4.0),
              spreadRadius: 0,
              blurRadius: 4.0,
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                left: 26,
                top: 15,
              ),
              child: Row(
                children: <Widget>[
                  AppIconsTheme.tack.svg(
                    size: 32,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    FlutterI18n.translate(
                      context,
                      'paymentSettingsScreen.tackBalance',
                    ),
                    style: AppTextTheme.poppins18Medium,
                  ),
                  const SizedBox(width: 35),
                  Text(
                    '\$ ${tackBalance.toStringAsFixed(2)}',
                    style: AppTextTheme.manrope30Bold.copyWith(
                      color: AppTheme.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 47),
            Padding(
              padding: const EdgeInsets.only(left: 76),
              child: IntrinsicHeight(
                child: Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        AppIconsTheme.add.svg(size: 31),
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
                    const SizedBox(width: 27),
                    AppDivider(
                      axis: Axis.vertical,
                      height: 50,
                      color: AppTheme.dividerSecondaryColor,
                    ),
                    const SizedBox(width: 27),
                    Column(
                      children: <Widget>[
                        AppIconsTheme.bankRounded.svg(size: 31),
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
      ),
    );
  }
}
