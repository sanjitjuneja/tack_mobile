import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import '../../../widgets/tack_keyboard/bloc/tack_keyboard_bloc.dart';
import '../bloc/add_to_tack_balance_bloc.dart';
import 'add_to_tack_balance_screen.dart';

class AddToTackBalanceFeature {
  static const String routeName = '/addToTackBalance';

  static Page<void> page() => const AddToTackBalancePage();
}

class AddToTackBalancePage extends Page<void> {
  @override
  String get name => AddToTackBalanceFeature.routeName;

  const AddToTackBalancePage();

  @override
  Route<void> createRoute(BuildContext context) {
    return CupertinoPageRoute<void>(
      settings: this,
      builder: (_) {
        return MultiBlocProvider(
          providers: <BlocProvider>[
            BlocProvider<AddToTackBalanceBloc>(
              create: (_) {
                return AddToTackBalanceBloc(
                  appRouter: appLocator.get<AppRouterDelegate>(),
                  fetchConnectedBankAccountsUseCase:
                      appLocator.get<FetchConnectedBankAccountsUseCase>(),
                  fetchConnectedCardsUseCase:
                      appLocator.get<FetchConnectedCardsUseCase>(),
                  fetchIsApplePaySupportedUseCase:
                      appLocator.get<FetchIsApplePaySupportedUseCase>(),
                  fetchIsGooglePaySupportedUseCase:
                      appLocator.get<FetchIsGooglePaySupportedUseCase>(),
                  getUserBalanceUseCase:
                      appLocator.get<GetUserBalanceUseCase>(),
                  observeUserBalanceUseCase:
                      appLocator.get<ObserveUserBalanceUseCase>(),
                  fetchUserBalanceUseCase:
                      appLocator.get<FetchUserBalanceUseCase>(),
                  handleDwollaDepositUseCase:
                      appLocator.get<HandleDwollaDepositUseCase>(),
                  handleStripeDepositUseCase:
                      appLocator.get<HandleStripeDepositUseCase>(),
                  fetchFeeUseCase: appLocator.get<FetchFeeUseCase>(),
                );
              },
            ),
            BlocProvider<TackKeyboardBloc>(
              create: (_) => TackKeyboardBloc(),
            ),
          ],
          child: const AddToTackBalanceScreen(),
        );
      },
    );
  }
}
