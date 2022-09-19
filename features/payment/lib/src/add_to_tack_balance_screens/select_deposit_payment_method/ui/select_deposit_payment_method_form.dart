import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/src/widgets/payment_method_tile.dart';
import '../bloc/select_deposit_payment_method_bloc.dart';

class SelectDepositPaymentMethodForm extends StatelessWidget {
  const SelectDepositPaymentMethodForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectDepositPaymentMethodBloc,
        SelectDepositPaymentMethodState>(
      builder: (_, SelectDepositPaymentMethodState state) {
        return AppScrollView(
          children: <Widget>[
            Center(
              child: Text(
                FlutterI18n.translate(
                  context,
                  'selectPaymentMethodScreen.title',
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
              Text(
                FlutterI18n.translate(
                  context,
                  'paymentSettingsScreen.banks',
                ),
                style: AppTextTheme.manrope20Bold,
              ),
              const SizedBox(height: 14),
              if (state.bankAccounts.isNotEmpty) ...<Widget>[
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
              ],
              PaymentMethodTile(
                leadingIcon: AppIconsTheme.bank(),
                title: FlutterI18n.translate(
                  context,
                  'selectPaymentMethodScreen.addBank',
                ),
                trailingIcon: AppIconsTheme.chevronRightRounded(
                  color: AppTheme.grassColor,
                  size: 30,
                ),
                feePercent: state.fee?.dwollaFeeData.feePercent,
                isSentenceCase: false,
                onTap: () => _onAddBankTap(context),
              ),
              const SizedBox(height: 30),
              Text(
                FlutterI18n.translate(
                  context,
                  'paymentSettingsScreen.cards',
                ),
                style: AppTextTheme.manrope20Bold,
              ),
              const SizedBox(height: 14),
              if (state.cards.isNotEmpty) ...<Widget>[
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
              ],
              PaymentMethodTile(
                leadingIcon: AppIconsTheme.card(),
                title: FlutterI18n.translate(
                  context,
                  'selectPaymentMethodScreen.addCard',
                ),
                trailingIcon: AppIconsTheme.chevronRightRounded(
                  color: AppTheme.grassColor,
                  size: 30,
                ),
                feePercent: state.fee?.stripeFeeData.feePercent,
                isSentenceCase: false,
                onTap: () => _onAddCardTap(context),
              ),
              const SizedBox(height: 30),
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
                    leadingIcon: AppIconsTheme.applePay(),
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
                    leadingIcon: AppIconsTheme.googlePay(),
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
            const SizedBox(height: 30),
            Row(
              children: <Widget>[
                const Spacer(),
                Expanded(
                  flex: 4,
                  child: AppCircleButton(
                    labelKey: 'selectPaymentMethodScreen.continue',
                    expanded: false,
                    onTap: () => _onContinuePress(context),
                  ),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }

  void _onPaymentMethodTileTap(
    BuildContext context, {
    required String paymentMethodId,
  }) {
    BlocProvider.of<SelectDepositPaymentMethodBloc>(context).add(
      SelectDepositPaymentMethodAction(paymentMethodId: paymentMethodId),
    );
  }

  void _onReloadButtonPressed(BuildContext context) {
    BlocProvider.of<SelectDepositPaymentMethodBloc>(context).add(
      const InitialLoad(),
    );
  }

  void _onAddBankTap(BuildContext context) {
    BlocProvider.of<SelectDepositPaymentMethodBloc>(context).add(
      const AddBankAction(),
    );
  }

  void _onAddCardTap(BuildContext context) {
    BlocProvider.of<SelectDepositPaymentMethodBloc>(context).add(
      const AddCardAction(),
    );
  }

  void _onContinuePress(BuildContext context) {
    BlocProvider.of<SelectDepositPaymentMethodBloc>(context).add(
      const ContinueAction(),
    );
  }
}
