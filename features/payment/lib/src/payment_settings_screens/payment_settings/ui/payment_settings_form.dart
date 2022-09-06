import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/src/widgets/payment_method_tile.dart';
import '/src/payment_settings_screens/payment_settings/widgets/tack_balance.dart';
import '../bloc/payment_settings_bloc.dart';
import '../../widgets/payment_info_label.dart';

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
              tackBalance: state.userBalance.usdBalance,
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
                child: CupertinoButton(
                  onPressed: () => _onReloadButtonPressed(context),
                  padding: EdgeInsets.zero,
                  child: Icon(
                    Icons.refresh_rounded,
                    color: AppTheme.progressInterfaceDarkColor,
                    size: 60,
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
                    onTap: () =>
                        _onPaymentMethodTile(context, bankAccount: bankAccount),
                    leadingIcon: AppNetworkImageWidget(
                      bankAccount.imageUrl,
                      placeholderIcon: AppIconsTheme.bank,
                      boxShape: BoxShape.rectangle,
                      boxFit: BoxFit.fitWidth,
                    ),
                    title: bankAccount.bankName,
                    subtitle: bankAccount.bankAccountType,
                    isPrimary: bankAccount.isPrimary,
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
                    onTap: () => _onPaymentMethodTile(context, card: card),
                    leadingIcon: AppNetworkImageWidget(
                      card.cardData.imageUrl,
                      placeholderIcon: AppIconsTheme.card,
                      boxShape: BoxShape.rectangle,
                      boxFit: BoxFit.fitWidth,
                    ),
                    title: card.cardData.brand,
                    subtitle: '****${card.cardData.last4}',
                    isPrimary: card.isPrimary,
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
                    leadingIcon: AppIconsTheme.applePay(size: 35),
                    title: FlutterI18n.translate(
                      context,
                      'paymentSettingsScreen.applePay',
                    ),
                    isPrimary: !state.isPrimaryMethodExists,
                    hasTrailingArrow: false,
                  ),
                if (state.isGooglePaySupported)
                  PaymentMethodTile(
                    leadingIcon: AppIconsTheme.googlePay(size: 35),
                    title: FlutterI18n.translate(
                      context,
                      'paymentSettingsScreen.googlePay',
                    ),
                    isPrimary: !state.isPrimaryMethodExists,
                    hasTrailingArrow: false,
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
              leadingIcon: AppIconsTheme.bank(size: 35),
              title: FlutterI18n.translate(
                context,
                'paymentSettingsScreen.addPaymentMethod',
              ),
              onTap: () => _onAddPaymentMethod(context),
            ),
            const SizedBox(height: 28),
            const PaymentInfoLabel(),
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

  void _onPaymentMethodTile(
    BuildContext context, {
    ConnectedCard? card,
    ConnectedBankAccount? bankAccount,
  }) {
    BlocProvider.of<PaymentSettingsBloc>(context).add(
      PaymentMethodDetailsAction(
        card: card,
        bankAccount: bankAccount,
      ),
    );
  }
}
