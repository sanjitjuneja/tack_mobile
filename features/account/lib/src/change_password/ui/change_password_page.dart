import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import '../bloc/change_password_bloc.dart';
import 'change_password_screen.dart';

class ChangePasswordFeature {
  static const String routeName = '/changePassword';

  static Page<bool?> page() {
    return const _ChangePasswordPage();
  }
}

class _ChangePasswordPage extends Page<bool?> {
  const _ChangePasswordPage();

  @override
  String get name => ChangePasswordFeature.routeName;

  @override
  Route<bool?> createRoute(BuildContext context) {
    return CupertinoPageRoute<bool?>(
      settings: this,
      builder: (_) {
        return BlocProvider<ChangePasswordBloc>(
          create: (_) {
            return ChangePasswordBloc(
              appRouter: GlobalAppRouter.of(context),
              changePasswordUseCase: appLocator.get<ChangePasswordUseCase>(),
            );
          },
          child: const ChangePasswordScreen(),
        );
      },
    );
  }
}
