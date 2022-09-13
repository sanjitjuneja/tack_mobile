import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/src/widgets/payment_method_tile.dart';
import '../bloc/select_pay_for_tack_payment_method_bloc.dart';

class SelectPayForTackPaymentMethodForm extends StatelessWidget {
  const SelectPayForTackPaymentMethodForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectPayForTackPaymentMethodBloc,
        SelectPayForTackPaymentMethodState>(
      builder: (_, SelectPayForTackPaymentMethodState state) {
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
            const SizedBox(height: 48),
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
                    leadingIcon: AppNetworkImageWidget(
                      bankAccount.imageUrl,
                      placeholderIcon: AppIconsTheme.bank,
                      boxShape: BoxShape.rectangle,
                      boxFit: BoxFit.fitWidth,
                    ),
                    title: bankAccount.bankName,
                    feePercent: state.fee?.dwollaFeeData.feePercent,
                    subtitle: bankAccount.bankAccountType,
                    isSelectable: true,
                    isSelected: state.selectedPaymentMethodId == bankAccount.id,
                    onTap: () {
                      _onPaymentMethodTileTap(
                        context,
                        paymentMethodId: bankAccount.id,
                      );
                    },
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
                    leadingIcon: AppNetworkImageWidget(
                      card.cardData.imageUrl,
                      placeholderIcon: AppIconsTheme.card,
                      boxShape: BoxShape.rectangle,
                      boxFit: BoxFit.fitWidth,
                    ),
                    title: card.cardData.brand,
                    subtitle: '****${card.cardData.last4}',
                    isSelectable: true,
                    isSelected: state.selectedPaymentMethodId == card.id,
                    feePercent: state.fee?.stripeFeeData.feePercent,
                    onTap: () {
                      _onPaymentMethodTileTap(
                        context,
                        paymentMethodId: card.id,
                      );
                    },
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
                    isSentenceCase: false,
                    isSelectable: true,
                    isSelected:
                        state.selectedPaymentMethodId == Constants.applePayId,
                    feePercent: state.fee?.stripeFeeData.feePercent,
                    onTap: () {
                      _onPaymentMethodTileTap(
                        context,
                        paymentMethodId: Constants.applePayId,
                      );
                    },
                  ),
                if (state.isGooglePaySupported)
                  PaymentMethodTile(
                    leadingIcon: AppIconsTheme.googlePay(size: 35),
                    title: FlutterI18n.translate(
                      context,
                      'paymentSettingsScreen.googlePay',
                    ),
                    isSelectable: true,
                    isSentenceCase: false,
                    isSelected:
                        state.selectedPaymentMethodId == Constants.googlePayId,
                    feePercent: state.fee?.stripeFeeData.feePercent,
                    onTap: () {
                      _onPaymentMethodTileTap(
                        context,
                        paymentMethodId: Constants.googlePayId,
                      );
                    },
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
              isSentenceCase: false,
              onTap: () => _onAddPaymentMethod(context),
            ),
            const SizedBox(height: 10)
          ],
        );
      },
    );
  }

  void _onPaymentMethodTileTap(
    BuildContext context, {
    required String paymentMethodId,
  }) {
    BlocProvider.of<SelectPayForTackPaymentMethodBloc>(context).add(
      SelectPayForTackPaymentMethodAction(paymentMethodId: paymentMethodId),
    );
  }

  void _onReloadButtonPressed(BuildContext context) {
    BlocProvider.of<SelectPayForTackPaymentMethodBloc>(context).add(
      const InitialLoad(),
    );
  }

  void _onAddPaymentMethod(BuildContext context) {
    BlocProvider.of<SelectPayForTackPaymentMethodBloc>(context).add(
      const AddPaymentMethodAction(),
    );
  }
}
