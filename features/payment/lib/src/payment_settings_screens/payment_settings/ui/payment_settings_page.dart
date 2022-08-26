import 'package:core/core.dart';
import 'package:domain/payment/payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';
import '../bloc/payment_settings_bloc.dart';
import 'payment_settings_screen.dart';

class PaymentSettingsFeature {
  static const String routeName = '/paymentSettings';

  static Page<void> page() => const PaymentSettingsPage();
}

class PaymentSettingsPage extends Page<void> {
  @override
  String get name => PaymentSettingsFeature.routeName;

  const PaymentSettingsPage();

  @override
  Route<void> createRoute(BuildContext context) {
    return CupertinoPageRoute<void>(
      settings: this,
      builder: (_) => BlocProvider<PaymentSettingsBloc>(
        create: (_) {
          return PaymentSettingsBloc(
            appRouter: appLocator.get<AppRouterDelegate>(),
            getConnectedBankAccountsUseCase:
                appLocator.get<GetConnectedBankAccountsUseCase>(),
            getConnectedCardsUseCase:
                appLocator.get<GetConnectedCardsUseCase>(),
          );
        },
        child: const PaymentSettingsScreen(),
      ),
    );
  }
}
