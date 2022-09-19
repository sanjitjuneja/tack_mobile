import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import '../ui/select_pay_for_tack_payment_method_screen.dart';
import '../../models/pay_for_tack_selected_payment_method.dart';
import '../bloc/select_pay_for_tack_payment_method_bloc.dart';

class SelectPayForTackPaymentMethodFeature {
  static const String routeName = '/selectPayForTackPaymentMethod';

  static Page<PayForTackSelectedPaymentMethod?> page({
    required double offerPrice,
    required String? selectedPaymentMethodId,
  }) {
    return SelectPayForTackPaymentMethodPage(
      selectedPaymentMethodId: selectedPaymentMethodId,
      offerPrice: offerPrice,
    );
  }
}

class SelectPayForTackPaymentMethodPage
    extends Page<PayForTackSelectedPaymentMethod?> {
  final String? selectedPaymentMethodId;
  final double offerPrice;

  @override
  String get name => SelectPayForTackPaymentMethodFeature.routeName;

  const SelectPayForTackPaymentMethodPage({
    required this.selectedPaymentMethodId,
    required this.offerPrice,
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
            getUserBalanceUseCase: appLocator.get<GetUserBalanceUseCase>(),
            observeUserBalanceUseCase:
                appLocator.get<ObserveUserBalanceUseCase>(),
            fetchUserBalanceUseCase: appLocator.get<FetchUserBalanceUseCase>(),
            fetchIsApplePaySupportedUseCase:
                appLocator.get<FetchIsApplePaySupportedUseCase>(),
            fetchIsGooglePaySupportedUseCase:
                appLocator.get<FetchIsGooglePaySupportedUseCase>(),
            selectedPaymentMethodId: selectedPaymentMethodId,
            offerPrice: offerPrice,
            feeUseCase: appLocator.get<FetchFeeUseCase>(),
            addBankAccountUseCase: appLocator.get<AddBankAccountUseCase>(),
          );
        },
        child: const SelectPayForTackPaymentMethodScreen(),
      ),
    );
  }
}
