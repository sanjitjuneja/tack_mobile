import 'package:core/core.dart';

import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import '../bloc/auth_error_bloc.dart';
import '../models/auth_error_type.dart';
import 'auth_error_screen.dart';

class AuthErrorFeature {
  static const String routeName = '/error';

  static Page<bool?> pageNotRegistered() =>
      const AuthErrorPage(errorType: AuthErrorType.notRegistered);

  static Page<bool?> pageAlreadyRegistered() =>
      const AuthErrorPage(errorType: AuthErrorType.alreadyRegistered);
}

class AuthErrorPage extends Page<bool?> {
  final AuthErrorType errorType;

  const AuthErrorPage({
    required this.errorType,
  });

  @override
  String get name => AuthErrorFeature.routeName;

  @override
  Route<bool?> createRoute(BuildContext context) {
    return CupertinoPageRoute<bool?>(
      settings: this,
      builder: (_) => BlocProvider<AuthErrorBloc>(
        create: (_) {
          return AuthErrorBloc(
            errorType: errorType,
            appRouter: GlobalAppRouter.of(context),
          );
        },
        child: const AuthErrorScreen(),
      ),
    );
  }
}
