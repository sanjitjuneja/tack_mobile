import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import '../bloc/select_pay_for_tack_payment_method_bloc.dart';
import 'select_pay_for_tack_payment_method_form.dart';

class SelectPayForTackPaymentMethodScreen extends StatelessWidget {
  const SelectPayForTackPaymentMethodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.secondaryBackgroundColor,
      navigationBar: AppNavigationBar(
        backgroundColor: AppTheme.secondaryBackgroundColor,
        withResult: true,
        leading: BlocBuilder<SelectPayForTackPaymentMethodBloc,
            SelectPayForTackPaymentMethodState>(
          builder: (_, SelectPayForTackPaymentMethodState state) {
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
        child: SelectPayForTackPaymentMethodForm(),
      ),
    );
  }
}
