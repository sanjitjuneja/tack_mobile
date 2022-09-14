import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import '../bloc/select_deposit_payment_method_bloc.dart';
import 'select_deposit_payment_method_form.dart';

class SelectDepositPaymentMethodScreen extends StatelessWidget {
  const SelectDepositPaymentMethodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.secondaryBackgroundColor,
      navigationBar: AppNavigationBar(
        backgroundColor: AppTheme.secondaryBackgroundColor,
        withResult: true,
        leading: BlocBuilder<SelectDepositPaymentMethodBloc,
            SelectDepositPaymentMethodState>(
          builder: (_, SelectDepositPaymentMethodState state) {
            return AppBackButton(
              onPressed: () {
                GlobalAppRouter.of(context).popWithResult(
                  state.selectedPaymentMethod,
                );
              },
            );
          },
        ),
      ),
      child: const SafeArea(
        child: SelectDepositPaymentMethodForm(),
      ),
    );
  }
}
