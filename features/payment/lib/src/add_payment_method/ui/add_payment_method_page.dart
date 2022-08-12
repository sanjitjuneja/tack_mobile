import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';
import '../bloc/add_payment_method_bloc.dart';
import 'add_payment_method_screen.dart';

class AddPaymentMethodFeature {
  static const String routeName = '/addPaymentMethod';

  static Page<void> page() => const AddPaymentMethodPage();
}

class AddPaymentMethodPage extends Page<void> {
  @override
  String get name => AddPaymentMethodFeature.routeName;

  const AddPaymentMethodPage();

  @override
  Route<void> createRoute(BuildContext context) {
    return CupertinoPageRoute<void>(
      settings: this,
      builder: (_) => BlocProvider<AddPaymentMethodBloc>(
        create: (_) {
          return AddPaymentMethodBloc(
            appRouter: appLocator.get<AppRouterDelegate>(),
          );
        },
        child: const AddPaymentMethodScreen(),
      ),
    );
  }
}
