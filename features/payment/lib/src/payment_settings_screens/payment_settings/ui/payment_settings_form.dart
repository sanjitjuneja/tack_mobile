import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '/src/widgets/payment_method_tile.dart';
import '/src/payment_settings_screens/payment_settings/widgets/tack_balance.dart';
import '../bloc/payment_settings_bloc.dart';

class PaymentSettingsForm extends StatelessWidget {
  const PaymentSettingsForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentSettingsBloc, PaymentSettingsState>(
      builder: (BuildContext context, PaymentSettingsState state) {
        return AppScrollView(
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
            TackBalance(
              tackBalance: 0.00,
              onAddCashTap: () => _onAddCash(context),
              onPayoutTap: () => _onPayout(context),
            ),
            const SizedBox(height: 30),
            if (state.isLoading) ...<Widget>[
              AppProgressIndicator(
                indicatorSize: ProgressIndicatorSize.medium,
                backgroundColor: AppTheme.transparentColor,
                indicatorColor: AppTheme.progressInterfaceDarkColor,
              ),
            ] else if (state.hasError) ...<Widget>[
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 40.0),
                child: IconButton(
                  onPressed: () => _onReloadButtonPressed(context),
                  padding: EdgeInsets.zero,
                  iconSize: 60,
                  icon: Icon(
                    Icons.refresh_rounded,
                    color: AppTheme.progressInterfaceDarkColor,
                  ),
                ),
              ),
            ] else ...<Widget>[
              if (state.bankAccounts.isNotEmpty) ...<Widget>[
                Text(
                  FlutterI18n.translate(
                    context,
                    'paymentSettingsScreen.banks',
                  ),
                  style: AppTextTheme.manrope20Bold,
                ),
                const SizedBox(height: 14),
                ...state.bankAccounts.map(
                  (bankAccount) => PaymentMethodTile(
                    leadingIcon: AppIconsTheme.bank,
                    title: bankAccount.bankName,
                    subtitle: bankAccount.bankAccountType,
                  ),
                ),
                const SizedBox(height: 30),
              ],
              if (state.cards.isNotEmpty) ...<Widget>[
                Text(
                  FlutterI18n.translate(
                    context,
                    'paymentSettingsScreen.cards',
                  ),
                  style: AppTextTheme.manrope20Bold,
                ),
                const SizedBox(height: 14),
                ...state.cards.map(
                  (card) => PaymentMethodTile(
                    leadingIcon: AppIconsTheme.card,
                    title: card.cardData.brand,
                    subtitle: '****${card.cardData.last4}',
                  ),
                ),
                const SizedBox(height: 30),
              ],
              if (state.digitalWalletsSupported) ...<Widget>[
                Text(
                  FlutterI18n.translate(
                    context,
                    'paymentSettingsScreen.digitalWallets',
                  ),
                  style: AppTextTheme.manrope20Bold,
                ),
                const SizedBox(height: 14),
                if (state.isApplePaySupported)
                  PaymentMethodTile(
                    leadingIcon: AppIconsTheme.applePay,
                    title: FlutterI18n.translate(
                      context,
                      'paymentSettingsScreen.applePay',
                    ),
                  ),
                if (state.isGooglePaySupported)
                  PaymentMethodTile(
                    leadingIcon: AppIconsTheme.applePay,
                    title: FlutterI18n.translate(
                      context,
                      'paymentSettingsScreen.googlePay',
                    ),
                  ),
                const SizedBox(height: 30),
              ],
            ],
            Text(
              FlutterI18n.translate(
                context,
                'paymentSettingsScreen.add',
              ),
              style: AppTextTheme.manrope20Bold,
            ),
            const SizedBox(height: 14),
            PaymentMethodTile(
              leadingIcon: AppIconsTheme.bank,
              title: FlutterI18n.translate(
                context,
                'paymentSettingsScreen.addPaymentMethod',
              ),
              onTap: () => _onAddPaymentMethod(context),
            ),
            const SizedBox(height: 28),
            Row(
              children: <Widget>[
                const Spacer(),
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
                const Spacer(),
              ],
            ),
            const SizedBox(height: 34),
          ],
        );
      },
    );
  }

  void _onAddPaymentMethod(BuildContext context) {
    BlocProvider.of<PaymentSettingsBloc>(context).add(
      const AddPaymentMethodAction(),
    );
  }

  void _onReloadButtonPressed(BuildContext context) {
    BlocProvider.of<PaymentSettingsBloc>(context).add(
      const InitialLoad(),
    );
  }

  void _onAddCash(BuildContext context) {
    BlocProvider.of<PaymentSettingsBloc>(context).add(
      const AddCashAction(),
    );
  }

  void _onPayout(BuildContext context) {
    BlocProvider.of<PaymentSettingsBloc>(context).add(
      const PayoutAction(),
    );
  }
}
