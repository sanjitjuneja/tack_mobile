import 'package:core/core.dart';
import 'package:domain/payment/payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import '../../../add_to_tack_balance_screens/models/selected_payment_method.dart';
import '../../select_deposit_payment_method_screen/ui/select_deposit_payment_method_screen.dart';
import '../bloc/select_deposit_payment_method_bloc.dart';

class SelectDepositPaymentMethodFeature {
  static const String routeName = '/selectDepositPaymentMethod';

  static Page<SelectedPaymentMethod?> page({
    required String? selectedPaymentMethodId,
  }) {
    return SelectDepositPaymentMethodPage(
      selectedPaymentMethodId: selectedPaymentMethodId,
    );
  }
}

class SelectDepositPaymentMethodPage extends Page<SelectedPaymentMethod?> {
  final String? selectedPaymentMethodId;

  @override
  String get name => SelectDepositPaymentMethodFeature.routeName;

  const SelectDepositPaymentMethodPage({
    required this.selectedPaymentMethodId,
  });

  @override
  Route<SelectedPaymentMethod?> createRoute(BuildContext context) {
    return CupertinoPageRoute<SelectedPaymentMethod?>(
      settings: this,
      builder: (_) => BlocProvider<SelectDepositPaymentMethodBloc>(
        create: (_) {
          return SelectDepositPaymentMethodBloc(
            appRouter: appLocator.get<AppRouterDelegate>(),
            fetchConnectedBankAccountsUseCase:
                appLocator.get<FetchConnectedBankAccountsUseCase>(),
            fetchConnectedCardsUseCase:
                appLocator.get<FetchConnectedCardsUseCase>(),
            fetchIsApplePaySupportedUseCase:
                appLocator.get<FetchIsApplePaySupportedUseCase>(),
            fetchIsGooglePaySupportedUseCase:
                appLocator.get<FetchIsGooglePaySupportedUseCase>(),
            selectedPaymentMethodId: selectedPaymentMethodId,
            feeUseCase: appLocator.get<FetchFeeUseCase>(),
          );
        },
        child: const SelectDepositPaymentMethodScreen(),
      ),
    );
  }
}
