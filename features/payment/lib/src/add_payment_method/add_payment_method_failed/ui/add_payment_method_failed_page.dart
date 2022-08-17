import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';
import '../bloc/add_payment_method_failed_bloc.dart';
import 'add_payment_method_failed_screen.dart';

class AddPaymentMethodFailedFeature {
  static const String routeName = '/addPaymentMethodFailed';

  static Page<void> page() => const AddPaymentMethodFailedPage();
}

class AddPaymentMethodFailedPage extends Page<void> {
  @override
  String get name => AddPaymentMethodFailedFeature.routeName;

  const AddPaymentMethodFailedPage();

  @override
  Route<void> createRoute(BuildContext context) {
    return CupertinoPageRoute<void>(
      settings: this,
      builder: (_) => BlocProvider<AddPaymentMethodFailedBloc>(
        create: (_) {
          return AddPaymentMethodFailedBloc(
            appRouter: appLocator.get<AppRouterDelegate>(),
          );
        },
        child: const AddPaymentMethodFailedScreen(),
      ),
    );
  }
}
