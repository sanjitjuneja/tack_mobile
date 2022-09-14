import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import '../bloc/select_withdraw_payment_method_bloc.dart';
import 'select_withdraw_payment_method_form.dart';

class SelectWithdrawPaymentMethodScreen extends StatelessWidget {
  const SelectWithdrawPaymentMethodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.secondaryBackgroundColor,
      navigationBar: AppNavigationBar(
        backgroundColor: AppTheme.secondaryBackgroundColor,
        withResult: true,
        leading: BlocBuilder<SelectWithdrawPaymentMethodBloc,
            SelectWithdrawPaymentMethodState>(
          builder: (_, SelectWithdrawPaymentMethodState state) {
            return AppBackButton(
              onPressed: () {
                GlobalAppRouter.of(context).popWithResult(
                  state.selectedBankAccount,
                );
              },
            );
          },
        ),
      ),
      child: const SafeArea(
        child: SelectWithdrawPaymentMethodForm(),
      ),
    );
  }
}
