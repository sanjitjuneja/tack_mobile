import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';
import '../bloc/add_to_tack_balance_successful_bloc.dart';
import 'add_to_tack_balance_successful_screen.dart';

class AddToTackBalanceSuccessfulFeature {
  static const String routeName = '/addToTackBalanceFailed';

  static Page<void> page() => const AddToTackBalanceSuccessfulPage();
}

class AddToTackBalanceSuccessfulPage extends Page<void> {
  @override
  String get name => AddToTackBalanceSuccessfulFeature.routeName;

  const AddToTackBalanceSuccessfulPage();

  @override
  Route<void> createRoute(BuildContext context) {
    return CupertinoPageRoute<void>(
      settings: this,
      builder: (_) => BlocProvider<AddToTackBalanceSuccessfulBloc>(
        create: (_) {
          return AddToTackBalanceSuccessfulBloc(
            appRouter: appLocator.get<AppRouterDelegate>(),
          );
        },
        child: const AddToTackBalanceSuccessfulScreen(),
      ),
    );
  }
}
