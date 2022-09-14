import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/src/widgets/payment_method_tile.dart';
import '../bloc/select_withdraw_payment_method_bloc.dart';

class SelectWithdrawPaymentMethodForm extends StatelessWidget {
  const SelectWithdrawPaymentMethodForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectWithdrawPaymentMethodBloc,
        SelectWithdrawPaymentMethodState>(
      builder: (BuildContext context, SelectWithdrawPaymentMethodState state) {
        return AppScrollView(
          children: <Widget>[
            Center(
              child: Text(
                FlutterI18n.translate(
                  context,
                  'selectWithdrawPaymentMethodScreen.title',
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
                    isSelected: state.selectedBankAccount == bankAccount,
                    onTap: () {
                      _onPaymentMethodTileTap(
                        context,
                        connectedBankAccount: bankAccount,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30),
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
                onTap: () => _onAddBankAccount(context),
              ),
            ],
          ],
        );
      },
    );
  }

  void _onPaymentMethodTileTap(
    BuildContext context, {
    required ConnectedBankAccount? connectedBankAccount,
  }) {
    BlocProvider.of<SelectWithdrawPaymentMethodBloc>(context).add(
      SelectWithdrawPaymentMethodAction(
        bankAccount: connectedBankAccount,
      ),
    );
  }

  void _onReloadButtonPressed(BuildContext context) {
    BlocProvider.of<SelectWithdrawPaymentMethodBloc>(context).add(
      const InitialLoad(),
    );
  }

  void _onAddBankAccount(BuildContext context) {
    BlocProvider.of<SelectWithdrawPaymentMethodBloc>(context).add(
      const AddBankAccountAction(),
    );
  }
}
