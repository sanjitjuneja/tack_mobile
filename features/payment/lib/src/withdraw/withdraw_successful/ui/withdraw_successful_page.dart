import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';
import 'package:payment/src/withdraw/withdraw_amount/widgets/withdraw_method_type.dart';
import '../bloc/withdraw_successful_bloc.dart';
import 'withdraw_successful_screen.dart';

class WithdrawSuccessfulFeature {
  static const String routeName = '/withdrawSuccessful';

  static Page<void> page({
    required WithdrawMethodType withdrawMethodType,
  }) {
    return WithdrawSuccessfulPage(
      withdrawMethodType: withdrawMethodType,
    );
  }
}

class WithdrawSuccessfulPage extends Page<void> {
  final WithdrawMethodType withdrawMethodType;

  @override
  String get name => WithdrawSuccessfulFeature.routeName;

  const WithdrawSuccessfulPage({
    required this.withdrawMethodType,
  });

  @override
  Route<void> createRoute(BuildContext context) {
    return CupertinoPageRoute<void>(
      settings: this,
      builder: (_) => BlocProvider<WithdrawSuccessfulBloc>(
        create: (_) {
          return WithdrawSuccessfulBloc(
            appRouter: appLocator.get<AppRouterDelegate>(),
          );
        },
        child: WithdrawSuccessfulScreen(
          withdrawMethodType: withdrawMethodType,
        ),
      ),
    );
  }
}
