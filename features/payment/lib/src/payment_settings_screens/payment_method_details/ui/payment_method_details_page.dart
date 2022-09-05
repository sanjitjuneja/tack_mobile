import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';
import '../bloc/payment_method_details_bloc.dart';
import 'payment_method_details_screen.dart';

class PaymentMethodDetailsFeature {
  static const String routeName = '/paymentMethodDetails';

  static Page<void> cardDetailsPage({
    required ConnectedCard card,
  }) {
    return _PaymentMethodDetailsPage(
      card: card,
    );
  }

  static Page<bool?> bankDetailsPage({
    required ConnectedBankAccount bankAccount,
  }) {
    return _PaymentMethodDetailsPage(
      bankAccount: bankAccount,
    );
  }
}

class _PaymentMethodDetailsPage extends Page<bool?> {
  final ConnectedCard? card;
  final ConnectedBankAccount? bankAccount;

  @override
  String get name => PaymentMethodDetailsFeature.routeName;

  const _PaymentMethodDetailsPage({
    this.card,
    this.bankAccount,
  }) : assert(card != null || bankAccount != null);

  @override
  Route<bool?> createRoute(BuildContext context) {
    return CupertinoPageRoute<bool?>(
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
