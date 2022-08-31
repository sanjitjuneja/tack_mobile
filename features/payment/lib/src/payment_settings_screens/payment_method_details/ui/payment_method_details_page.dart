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

  static Page<void> bankDetailsPage({
    required ConnectedBankAccount bankAccount,
  }) {
    return _PaymentMethodDetailsPage(
      bankAccount: bankAccount,
    );
  }
}

class _PaymentMethodDetailsPage extends Page<void> {
  final ConnectedCard? card;
  final ConnectedBankAccount? bankAccount;

  @override
  String get name => PaymentMethodDetailsFeature.routeName;

  const _PaymentMethodDetailsPage({
    this.card,
    this.bankAccount,
  }) : assert(card != null || bankAccount != null);

  @override
  Route<void> createRoute(BuildContext context) {
    return CupertinoPageRoute<void>(
      settings: this,
      builder: (_) => BlocProvider<PaymentMethodDetailsBloc>(
        create: (_) {
          return PaymentMethodDetailsBloc(
            appRouter: appLocator.get<AppRouterDelegate>(),
            addCardUseCase: appLocator.get<AddCardUseCase>(),
            card: card,
            bankAccount: bankAccount,
          );
        },
        child: const PaymentMethodDetailsScreen(),
      ),
    );
  }
}
