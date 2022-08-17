import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';
import '../bloc/withdraw_amount_bloc.dart';
import '/src/widgets/tack_keyboard/bloc/tack_keyboard_bloc.dart';
import 'withdraw_amount_screen.dart';

class WithdrawAmountFeature {
  static const String routeName = '/withdraw';

  static Page<void> page() => const WithdrawAmountPage();
}

class WithdrawAmountPage extends Page<void> {
  @override
  String get name => WithdrawAmountFeature.routeName;

  const WithdrawAmountPage();

  @override
  Route<void> createRoute(BuildContext context) {
    return CupertinoPageRoute<void>(
      settings: this,
      builder: (_) {
        return MultiBlocProvider(
          providers: <BlocProvider>[
            BlocProvider<WithdrawAmountBloc>(
              create: (_) {
                return WithdrawAmountBloc(
                  appRouter: appLocator.get<AppRouterDelegate>(),
                );
              },
            ),
            BlocProvider<TackKeyboardBloc>(
              create: (_) => TackKeyboardBloc(),
            ),
          ],
          child: const WithdrawAmountScreen(),
        );
      },
    );
  }
}
