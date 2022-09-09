import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../bloc/add_to_tack_balance_bloc.dart';
import '/src/widgets/payment_method_tile.dart';
import '../../../widgets/tack_keyboard/ui/tack_keyboard.dart';

class AddToTackBalanceForm extends StatelessWidget {
  const AddToTackBalanceForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddToTackBalanceBloc, AddToTackBalanceState>(
      builder: (_, AddToTackBalanceState state) {
        return Column(
          children: <Widget>[
            Center(
              child: Text(
                FlutterI18n.translate(
                  context,
                  'addToTackBalanceScreen.title',
                ),
                style: AppTextTheme.manrope24SemiBold,
              ),
            ),
            const SizedBox(height: 25),
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
                  onPressed: () => {},
                  padding: EdgeInsets.zero,
                  child: Icon(
                    Icons.refresh_rounded,
                    color: AppTheme.progressInterfaceDarkColor,
                    size: 60,
                  ),
                ),
              ),
            ] else ...<Widget>[
              if (state.selectedPaymentMethod.card != null) ...<Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: PaymentMethodTile(
                    leadingIcon: AppNetworkImageWidget(
                      state.selectedPaymentMethod.card!.cardData.imageUrl,
                      placeholderIcon: AppIconsTheme.card,
                      boxShape: BoxShape.rectangle,
                      boxFit: BoxFit.fitWidth,
                      isShadowBorder: false,
                    ),
                    onTap: () => _onSelectPaymentMethod(context),
                    title: state.selectedPaymentMethod.card!.cardData.brand,
                    subtitle:
                        '*****${state.selectedPaymentMethod.card!.cardData.last4}',
                    isColored: true,
                  ),
                ),
              ] else if (state.selectedPaymentMethod.bankAccount !=
                  null) ...<Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: PaymentMethodTile(
                    leadingIcon: AppNetworkImageWidget(
                      state.selectedPaymentMethod.bankAccount!.imageUrl,
                      placeholderIcon: AppIconsTheme.bank,
                      boxShape: BoxShape.rectangle,
                      boxFit: BoxFit.fitWidth,
                      isShadowBorder: false,
                    ),
                    onTap: () => _onSelectPaymentMethod(context),
                    title: state.selectedPaymentMethod.bankAccount!.bankName,
                    subtitle: state
                        .selectedPaymentMethod.bankAccount!.bankAccountType,
                    isColored: true,
                  ),
                ),
              ] else if (state.selectedPaymentMethod.isApplePay) ...<Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: PaymentMethodTile(
                    leadingIcon: AppIconsTheme.applePay(size: 35),
                    onTap: () => _onSelectPaymentMethod(context),
                    title: FlutterI18n.translate(
                      context,
                      'paymentSettingsScreen.applePay',
                    ),
                    isColored: true,
                  ),
                ),
              ] else if (state.selectedPaymentMethod.isGooglePay) ...<Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: PaymentMethodTile(
                    leadingIcon: AppIconsTheme.googlePay(size: 35),
                    onTap: () => _onSelectPaymentMethod(context),
                    title: FlutterI18n.translate(
                      context,
                      'paymentSettingsScreen.googlePay',
                    ),
                    isColored: true,
                  ),
                ),
              ] else ...<Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: PaymentMethodTile(
                    leadingIcon: AppIconsTheme.bank(size: 35),
                    onTap: () => _onSelectPaymentMethod(context),
                    title: FlutterI18n.translate(
                      context,
                      'addToTackBalanceScreen.selectPaymentMethod',
                    ),
                    subtitle: FlutterI18n.translate(
                      context,
                      'addToTackBalanceScreen.bankOrCard',
                    ),
                    isColored: true,
                  ),
                ),
              ],
            ],
            const SizedBox(height: 45),
            TackKeyboard(
              subtitleKey: state.amount > 0
                  ? 'addToTackBalanceScreen.newTackBalance'
                  : 'addToTackBalanceScreen.currentTackBalance',
              hasLimits: true,
              feePercent: state.currentFeePercent,
              feeMinAmount: state.currentMinFeeAmount,
              feeMaxAmount: state.currentMaxFeeAmount,
              minErrorKey: 'addToTackBalanceScreen.minDepositLimitErrorMessage',
              maxErrorKey: 'addToTackBalanceScreen.maxDepositLimitErrorMessage',
              amount: state.userBalance.usdBalance + state.amount,
              onChanged: (double amount) {
                _onUpdateDepositAmountAction(context, amount: amount);
              },
            ),
            const Spacer(),
            Row(
              children: <Widget>[
                const Spacer(),
                Expanded(
                  flex: 4,
                  child: AppCircleButton(
                    labelKey: 'addToTackBalanceScreen.deposit',
                    expanded: false,
                    isDisabled: !state.isReadyToProceed,
                    onTap: () => _onDepositTap(context),
                  ),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 36),
          ],
        );
      },
    );
  }

  void _onUpdateDepositAmountAction(
    BuildContext context, {
    required double amount,
  }) {
    BlocProvider.of<AddToTackBalanceBloc>(context).add(
      UpdateDepositAmountAction(amount: amount),
    );
  }

  void _onDepositTap(BuildContext context) {
    BlocProvider.of<AddToTackBalanceBloc>(context).add(
      const MakeAddToTackBalanceRequest(),
    );
  }

  void _onSelectPaymentMethod(BuildContext context) {
    BlocProvider.of<AddToTackBalanceBloc>(context).add(
      const SelectPaymentMethodAction(),
    );
  }
}
