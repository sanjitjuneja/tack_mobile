import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';
import '../bloc/add_to_tack_balance_amount_bloc.dart';
import '/src/widgets/tack_keyboard/bloc/tack_keyboard_bloc.dart';
import 'add_to_tack_balance_amount_screen.dart';

class AddToTackBalanceAmountFeature {
  static const String routeName = '/addToTackBalanceAmount';

  static Page<void> page() => const AddToTackBalanceAmountPage();
}

class AddToTackBalanceAmountPage extends Page<void> {
  @override
  String get name => AddToTackBalanceAmountFeature.routeName;

  const AddToTackBalanceAmountPage();

  @override
  Route<void> createRoute(BuildContext context) {
    return CupertinoPageRoute<void>(
      settings: this,
      builder: (_) {
        return MultiBlocProvider(
          providers: <BlocProvider>[
            BlocProvider<AddToTackBalanceAmountBloc>(
              create: (_) {
                return AddToTackBalanceAmountBloc(
                  appRouter: appLocator.get<AppRouterDelegate>(),
                );
              },
            ),
            BlocProvider<TackKeyboardBloc>(
              create: (_) => TackKeyboardBloc(),
            ),
          ],
          child: const AddToTackBalanceAmountScreen(),
        );
      },
    );
  }
}
