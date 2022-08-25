import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import '../bloc/account_settings_bloc.dart';
import 'account_settings_screen.dart';

class AccountSettingsFeature {
  static const String routeName = '/accountSettings';

  static Page<bool?> page() {
    return const _AccountSettingsPage();
  }
}

class _AccountSettingsPage extends Page<bool?> {
  @override
  String get name => AccountSettingsFeature.routeName;

  const _AccountSettingsPage();

  @override
  Route<bool?> createRoute(BuildContext context) {
    return CupertinoPageRoute<bool?>(
      settings: this,
      builder: (_) => BlocProvider<AccountSettingsBloc>(
        create: (_) {
          return AccountSettingsBloc(
            appRouter: AppRouter.of(context),
            getCurrentUserUseCase: appLocator.get<GetCurrentUserUseCase>(),
            updateUserInfoUseCase: appLocator.get<UpdateUserInfoUseCase>(),
          );
        },
        child: const AccountSettingsScreen(),
      ),
    );
  }
}
