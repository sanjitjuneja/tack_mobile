import 'package:core/core.dart';
import 'package:domain/payment/payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import '../../../add_to_tack_balance_screens/models/selected_payment_method.dart';
import '../../select_payment_method_screen/ui/select_payment_method_screen.dart';
import '../bloc/select_payment_method_bloc.dart';

class SelectPaymentMethodFeature {
  static const String routeName = '/selectPaymentMethod';

  static Page<SelectedPaymentMethod?> page({
    required String? selectedPaymentMethodId,
  }) {
    return SelectPaymentMethodPage(
      selectedPaymentMethodId: selectedPaymentMethodId,
    );
  }
}

class SelectPaymentMethodPage extends Page<SelectedPaymentMethod?> {
  final String? selectedPaymentMethodId;

  @override
  String get name => SelectPaymentMethodFeature.routeName;

  const SelectPaymentMethodPage({
    required this.selectedPaymentMethodId,
  });

  @override
  Route<SelectedPaymentMethod?> createRoute(BuildContext context) {
    return CupertinoPageRoute<SelectedPaymentMethod?>(
      settings: this,
      builder: (_) => BlocProvider<SelectPaymentMethodBloc>(
        create: (_) {
          return SelectPaymentMethodBloc(
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
        child: const SelectPaymentMethodScreen(),
      ),
    );
  }
}
