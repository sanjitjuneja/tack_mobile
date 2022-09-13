import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../bloc/withdraw_bloc.dart';
import '/src/widgets/payment_method_tile.dart';
import '../../../widgets/tack_keyboard/ui/tack_keyboard.dart';

class WithdrawForm extends StatelessWidget {
  const WithdrawForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WithdrawBloc, WithdrawState>(
      builder: (BuildContext context, WithdrawState state) {
        return Column(
          children: <Widget>[
            Center(
              child: Text(
                FlutterI18n.translate(
                  context,
                  'withdrawScreen.title',
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
              if (state.selectedBankAccount != null) ...<Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: PaymentMethodTile(
                    leadingIcon: AppNetworkImageWidget(
                      state.selectedBankAccount!.imageUrl,
                      placeholderIcon: AppIconsTheme.bank,
                      boxShape: BoxShape.rectangle,
                      boxFit: BoxFit.fitWidth,
                      isShadowBorder: false,
                    ),
                    onTap: () => _onSelectBankAccount(context),
                    title: state.selectedBankAccount!.bankName,
                    subtitle: state.selectedBankAccount!.bankAccountType,
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
                    onTap: () => _onSelectBankAccount(context),
                    title: FlutterI18n.translate(
                      context,
                      'withdrawScreen.selectBankAccount',
                    ),
                    isSentenceCase: false,
                    isColored: true,
                  ),
                ),
              ],
            ],
            ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 46,
              ),
            ),
            TackKeyboard(
              subtitleKey: state.withdrawAmount > 0
                  ? 'withdrawScreen.newTackBalance'
                  : 'withdrawScreen.currentTackBalance',
              hasLimits: true,
              minAmount: Constants.minWithdrawLimitAmount,
              maxAmount: state.maxWithdrawLimit,
              feePercent: state.fee?.dwollaFeeData.feePercent ?? 0,
              feeMinAmount: state.fee?.dwollaFeeData.feeMin ?? 0,
              feeMaxAmount: state.fee?.dwollaFeeData.feeMax ?? 0,
              minErrorKey: 'withdrawScreen.minWithdrawLimitErrorMessage',
              maxErrorKey: 'withdrawScreen.maxWithdrawLimitErrorMessage',
              amount: state.userBalance.usdBalance - state.withdrawAmount,
              onChanged: (double amount) {
                _onUpdateWithdrawAmountAction(
                  context,
                  withdrawAmount: amount,
                );
              },
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 46,
              ),
            ),
            Row(
              children: <Widget>[
                const Spacer(),
                Expanded(
                  flex: 4,
                  child: AppCircleButton(
                    labelKey: 'withdrawScreen.withdraw',
                    expanded: false,
                    isDisabled: !state.isReadyToProceed,
                    onTap: () => _onWithdrawPress(context),
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

  void _onWithdrawPress(BuildContext context) {
    BlocProvider.of<WithdrawBloc>(context).add(
      const MakeWithdrawRequest(),
    );
  }

  void _onSelectBankAccount(BuildContext context) {
    BlocProvider.of<WithdrawBloc>(context).add(
      const SelectBankAccountAction(),
    );
  }

  void _onUpdateWithdrawAmountAction(
    BuildContext context, {
    required double withdrawAmount,
  }) {
    BlocProvider.of<WithdrawBloc>(context).add(
      UpdateWithdrawAmountAction(
        withdrawAmount: withdrawAmount,
      ),
    );
  }
}
