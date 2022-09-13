import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import '../bloc/add_payment_method_bloc.dart';
import '../models/add_payment_method_screen_result.dart';
import 'add_payment_method_screen.dart';

class AddPaymentMethodFeature {
  static const String routeName = '/addPaymentMethod';

  static Page<AddPaymentMethodScreenResult?> page({
    required int bankAccountsAmount,
  }) {
    return AddPaymentMethodPage(
      bankAccountsAmount: bankAccountsAmount,
    );
  }
}

class AddPaymentMethodPage extends Page<AddPaymentMethodScreenResult?> {
  final int bankAccountsAmount;

  @override
  String get name => AddPaymentMethodFeature.routeName;

  const AddPaymentMethodPage({
    required this.bankAccountsAmount,
  });

  @override
  Route<AddPaymentMethodScreenResult?> createRoute(BuildContext context) {
    return CupertinoPageRoute<AddPaymentMethodScreenResult?>(
      settings: this,
      builder: (_) => BlocProvider<AddPaymentMethodBloc>(
        create: (_) {
          return AddPaymentMethodBloc(
            appRouter: appLocator.get<AppRouterDelegate>(),
            addBankAccountUseCase: appLocator.get<AddBankAccountUseCase>(),
            bankAccountsAmount: bankAccountsAmount,
          );
        },
        child: const AddPaymentMethodScreen(),
      ),
    );
  }
}
