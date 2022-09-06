import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import '../../payment_settings/models/payment_method_details_screen_result.dart';
import '../bloc/payment_method_details_bloc.dart';
import 'payment_method_details_screen.dart';

class PaymentMethodDetailsFeature {
  static const String routeName = '/paymentMethodDetails';

  static Page<PaymentMethodDetailsScreenResult?> cardDetailsPage({
    required ConnectedCard card,
  }) {
    return _PaymentMethodDetailsPage(
      card: card,
    );
  }

  static Page<PaymentMethodDetailsScreenResult?> bankDetailsPage({
    required ConnectedBankAccount bankAccount,
  }) {
    return _PaymentMethodDetailsPage(
      bankAccount: bankAccount,
    );
  }
}

class _PaymentMethodDetailsPage
    extends Page<PaymentMethodDetailsScreenResult?> {
  final ConnectedCard? card;
  final ConnectedBankAccount? bankAccount;

  @override
  String get name => PaymentMethodDetailsFeature.routeName;

  const _PaymentMethodDetailsPage({
    this.card,
    this.bankAccount,
  }) : assert(card != null || bankAccount != null);

  @override
  Route<PaymentMethodDetailsScreenResult?> createRoute(BuildContext context) {
    return CupertinoPageRoute<PaymentMethodDetailsScreenResult?>(
      settings: this,
      builder: (_) => BlocProvider<PaymentMethodDetailsBloc>(
        create: (_) {
          return PaymentMethodDetailsBloc(
            appRouter: appLocator.get<AppRouterDelegate>(),
            removePaymentMethodUseCase:
                appLocator.get<RemovePaymentMethodUseCase>(),
            setPrimaryPaymentMethodUseCase:
                appLocator.get<SetPrimaryPaymentMethodUseCase>(),
            card: card,
            bankAccount: bankAccount,
          );
        },
        child: const PaymentMethodDetailsScreen(),
      ),
    );
  }
}
