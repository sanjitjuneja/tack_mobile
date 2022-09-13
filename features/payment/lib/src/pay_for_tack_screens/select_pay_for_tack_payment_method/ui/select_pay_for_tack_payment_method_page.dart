import 'package:core/core.dart';
import 'package:domain/payment/payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import '../ui/select_pay_for_tack_payment_method_screen.dart';
import '../../models/pay_for_tack_selected_payment_method.dart';
import '../bloc/select_pay_for_tack_payment_method_bloc.dart';

class SelectPayForTackPaymentMethodFeature {
  static const String routeName = '/selectPayForTackPaymentMethod';

  static Page<PayForTackSelectedPaymentMethod?> page({
    required String? selectedPaymentMethodId,
  }) {
    return SelectPayForTackPaymentMethodPage(
      selectedPaymentMethodId: selectedPaymentMethodId,
    );
  }
}

class SelectPayForTackPaymentMethodPage
    extends Page<PayForTackSelectedPaymentMethod?> {
  final String? selectedPaymentMethodId;

  @override
  String get name => SelectPayForTackPaymentMethodFeature.routeName;

  const SelectPayForTackPaymentMethodPage({
    required this.selectedPaymentMethodId,
  });

  @override
  Route<PayForTackSelectedPaymentMethod?> createRoute(BuildContext context) {
    return CupertinoPageRoute<PayForTackSelectedPaymentMethod?>(
      settings: this,
      builder: (_) => BlocProvider<SelectPayForTackPaymentMethodBloc>(
        create: (_) {
          return SelectPayForTackPaymentMethodBloc(
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
        child: const SelectPayForTackPaymentMethodScreen(),
      ),
    );
  }
}
