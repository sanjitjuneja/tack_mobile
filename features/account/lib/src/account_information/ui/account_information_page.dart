import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import '../bloc/account_information_bloc.dart';
import 'account_information_screen.dart';

class AccountInformationFeature {
  static const String routeName = '/accountInformation';

  static Page<void> page() {
    return const _AccountInformationPage();
  }
}

class _AccountInformationPage extends Page<void> {
  @override
  String get name => AccountInformationFeature.routeName;

  const _AccountInformationPage();

  @override
  Route<void> createRoute(BuildContext context) {
    return CupertinoPageRoute<void>(
      settings: this,
      builder: (_) => BlocProvider<AccountInformationBloc>(
        create: (_) {
          return AccountInformationBloc(
            globalAppRouterDelegate: appLocator.get<GlobalAppRouterDelegate>(),
            appRouter: AppRouter.of(context),
            getCurrentUserUseCase: appLocator.get<GetCurrentUserUseCase>(),
            observeUserUseCase: appLocator.get<ObserveUserUseCase>(),
            deleteAccountUseCase: appLocator.get<DeleteAccountUseCase>(),
            logOutUseCase: appLocator.get<LogOutUseCase>(),
          );
        },
        child: const AccountInformationScreen(),
      ),
    );
  }
}
