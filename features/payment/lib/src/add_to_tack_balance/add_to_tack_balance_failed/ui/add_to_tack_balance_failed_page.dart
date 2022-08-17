import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';
import '../bloc/add_to_tack_balance_failed_bloc.dart';
import 'add_to_tack_balance_failed_screen.dart';

class AddToTackBalanceFailedFeature {
  static const String routeName = '/addToTackBalanceFailed';

  static Page<void> page() => const AddToTackBalanceFailedPage();
}

class AddToTackBalanceFailedPage extends Page<void> {
  @override
  String get name => AddToTackBalanceFailedFeature.routeName;

  const AddToTackBalanceFailedPage();

  @override
  Route<void> createRoute(BuildContext context) {
    return CupertinoPageRoute<void>(
      settings: this,
      builder: (_) => BlocProvider<AddToTackBalanceFailedBloc>(
        create: (_) {
          return AddToTackBalanceFailedBloc(
            appRouter: appLocator.get<AppRouterDelegate>(),
          );
        },
        child: const AddToTackBalanceFailedScreen(),
      ),
    );
  }
}
