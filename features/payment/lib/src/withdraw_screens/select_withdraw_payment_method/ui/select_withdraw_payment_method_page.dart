import 'package:core/core.dart';
import 'package:domain/payment/payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import '../../select_withdraw_payment_method/ui/select_withdraw_payment_method_screen.dart';
import '../bloc/select_withdraw_payment_method_bloc.dart';

class SelectWithdrawPaymentMethodFeature {
  static const String routeName = '/selectWithdrawPaymentMethod';

  static Page<ConnectedBankAccount?> page({
    required ConnectedBankAccount? selectedBankAccount,
  }) {
    return SelectWithdrawPaymentMethodPage(
      selectedBankAccount: selectedBankAccount,
    );
  }
}

class SelectWithdrawPaymentMethodPage extends Page<ConnectedBankAccount?> {
  final ConnectedBankAccount? selectedBankAccount;

  @override
  String get name => SelectWithdrawPaymentMethodFeature.routeName;

  const SelectWithdrawPaymentMethodPage({
    required this.selectedBankAccount,
  });

  @override
  Route<ConnectedBankAccount?> createRoute(BuildContext context) {
    return CupertinoPageRoute<ConnectedBankAccount?>(
      settings: this,
      builder: (_) => BlocProvider<SelectWithdrawPaymentMethodBloc>(
        create: (_) {
          return SelectWithdrawPaymentMethodBloc(
            appRouter: appLocator.get<AppRouterDelegate>(),
            fetchConnectedBankAccountsUseCase:
                appLocator.get<FetchConnectedBankAccountsUseCase>(),
            selectedBankAccount: selectedBankAccount,
            feeUseCase: appLocator.get<FetchFeeUseCase>(),
            addBankAccountUseCase: appLocator.get<AddBankAccountUseCase>(),
          );
        },
        child: const SelectWithdrawPaymentMethodScreen(),
      ),
    );
  }
}
