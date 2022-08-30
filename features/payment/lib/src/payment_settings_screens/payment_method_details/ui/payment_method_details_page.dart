import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';
import '../bloc/payment_method_details_bloc.dart';
import 'payment_method_details_screen.dart';

class PaymentMethodDetailsFeature {
  static const String routeName = '/paymentMethodDetails';

  static Page<void> page({
    required ConnectedCard? card,
    required ConnectedBankAccount? bankAccount,
  }) {
    return PaymentMethodDetailsPage(
      card: card,
      bankAccount: bankAccount,
    );
  }
}

class PaymentMethodDetailsPage extends Page<void> {
  final ConnectedCard? card;
  final ConnectedBankAccount? bankAccount;

  @override
  String get name => PaymentMethodDetailsFeature.routeName;

  const PaymentMethodDetailsPage({
    required this.card,
    required this.bankAccount,
  });

  @override
  Route<void> createRoute(BuildContext context) {
    return CupertinoPageRoute<void>(
      settings: this,
      builder: (_) => BlocProvider<PaymentMethodDetailsBloc>(
        create: (_) {
          return PaymentMethodDetailsBloc(
            appRouter: appLocator.get<AppRouterDelegate>(),
            addCardUseCase: appLocator.get<AddCardUseCase>(),
          );
        },
        child: PaymentMethodDetailsScreen(
          card: card,
          bankAccount: bankAccount,
        ),
      ),
    );
  }
}
