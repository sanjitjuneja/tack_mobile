import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';
import '../bloc/add_credit_card_bloc.dart';
import 'add_credit_card_screen.dart';

class AddCreditCardFeature {
  static const String routeName = '/addCreditCard';

  static Page<void> page() => const AddCreditCardPage();
}

class AddCreditCardPage extends Page<bool> {
  @override
  String get name => AddCreditCardFeature.routeName;

  const AddCreditCardPage();

  @override
  Route<bool> createRoute(BuildContext context) {
    return CupertinoPageRoute<bool>(
      settings: this,
      builder: (_) => BlocProvider<AddCreditCardBloc>(
        create: (_) {
          return AddCreditCardBloc(
            appRouter: appLocator.get<AppRouterDelegate>(),
            addCardUseCase: appLocator.get<AddCardUseCase>(),
          );
        },
        child: const AddCreditCardScreen(),
      ),
    );
  }
}
