import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';
import '../bloc/add_credit_card_bloc.dart';
import 'add_credit_card_screen.dart';

class AddCreditCardFeature {
  static const String routeName = '/addCreditCard';

  static Page<void> page() => const AddCreditCardPage();
}

class AddCreditCardPage extends Page<void> {
  @override
  String get name => AddCreditCardFeature.routeName;

  const AddCreditCardPage();

  @override
  Route<void> createRoute(BuildContext context) {
    return CupertinoPageRoute<void>(
      settings: this,
      builder: (_) => BlocProvider<AddCreditCardBloc>(
        create: (_) {
          return AddCreditCardBloc(
            appRouter: appLocator.get<AppRouterDelegate>(),
          );
        },
        child: const AddCreditCardScreen(),
      ),
    );
  }
}
