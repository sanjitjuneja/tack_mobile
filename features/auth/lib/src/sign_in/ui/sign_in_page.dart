import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import '../bloc/sign_in_bloc.dart';
import 'sign_in_screen.dart';

class SignInFeature {
  static const String routeName = '/signIn';

  static Page<bool?> page() => const SignInPage();
}

class SignInPage extends Page<bool?> {
  const SignInPage();

  @override
  String get name => SignInFeature.routeName;

  @override
  Route<bool?> createRoute(BuildContext context) {
    return CupertinoPageRoute<bool?>(
      settings: this,
      builder: (_) => BlocProvider<SignInBloc>(
        create: (_) {
          return SignInBloc(
            appRouter: GlobalAppRouter.of(context),
            signInUseCase: appLocator.get<SignInUseCase>(),
          );
        },
        child: const SignInScreen(),
      ),
    );
  }
}
