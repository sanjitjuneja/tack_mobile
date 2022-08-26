import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';
import '../../../widgets/tack_keyboard/bloc/tack_keyboard_bloc.dart';
import '../bloc/withdraw_bloc.dart';
import 'withdraw_screen.dart';

class WithdrawFeature {
  static const String routeName = '/withdraw';

  static Page<void> page() => const WithdrawPage();
}

class WithdrawPage extends Page<void> {
  @override
  String get name => WithdrawFeature.routeName;

  const WithdrawPage();

  @override
  Route<void> createRoute(BuildContext context) {
    return CupertinoPageRoute<void>(
      settings: this,
      builder: (_) {
        return MultiBlocProvider(
          providers: <BlocProvider>[
            BlocProvider<WithdrawBloc>(
              create: (_) {
                return WithdrawBloc(
                  appRouter: appLocator.get<AppRouterDelegate>(),
                );
              },
            ),
            BlocProvider<TackKeyboardBloc>(
              create: (_) => TackKeyboardBloc(),
            ),
          ],
          child: const WithdrawScreen(),
        );
      },
    );
  }
}
