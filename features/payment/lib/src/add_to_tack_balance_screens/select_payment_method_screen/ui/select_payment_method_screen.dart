import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import '../bloc/select_payment_method_bloc.dart';
import 'select_payment_method_form.dart';

class SelectPaymentMethodScreen extends StatelessWidget {
  const SelectPaymentMethodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.secondaryBackgroundColor,
      navigationBar: AppNavigationBar(
        backgroundColor: AppTheme.secondaryBackgroundColor,
        withResult: true,
        leading: BlocBuilder<SelectPaymentMethodBloc, SelectPaymentMethodState>(
          builder: (_, SelectPaymentMethodState state) {
            return CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                GlobalAppRouter.of(context).popWithResult(
                  state.selectedPaymentMethod,
                );
              },
              child: Row(
                children: <Widget>[
                  AppIconsTheme.chevronLeft(
                    color: AppTheme.topNavBarInterfaceColor,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    FlutterI18n.translate(context, 'general.back'),
                    style: AppTextTheme.manrope16Regular.copyWith(
                      color: AppTheme.topNavBarInterfaceColor,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      child: const SafeArea(
        child: SelectPaymentMethodForm(),
      ),
    );
  }
}
