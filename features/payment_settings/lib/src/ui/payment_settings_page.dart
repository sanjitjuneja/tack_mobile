import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';
import 'payment_settings_screen.dart';
import '/src/bloc/payment_settings_bloc.dart';

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
          );
        },
        child: const PaymentSettingsScreen(),
      ),
    );
  }
}
