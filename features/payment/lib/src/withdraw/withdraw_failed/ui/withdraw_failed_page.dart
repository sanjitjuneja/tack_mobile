import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import '../bloc/withdraw_failed_bloc.dart';
import 'withdraw_failed_screen.dart';

class WithdrawFailedFeature {
  static const String routeName = '/withdrawFailed';

  static Page<void> page() => const WithdrawFailedPage();
}

class WithdrawFailedPage extends Page<void> {
  @override
  String get name => WithdrawFailedFeature.routeName;

  const WithdrawFailedPage();

  @override
  Route<void> createRoute(BuildContext context) {
    return CupertinoPageRoute<void>(
      settings: this,
      builder: (_) => BlocProvider<WithdrawFailedBloc>(
        create: (_) {
          return WithdrawFailedBloc(
            appRouter: appLocator.get<AppRouterDelegate>(),
          );
        },
        child: const WithdrawFailedScreen(),
      ),
    );
  }
}
