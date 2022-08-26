import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import '../models/auth_error_type.dart';

part 'auth_error_event.dart';

part 'auth_error_state.dart';

class AuthErrorBloc extends Bloc<AuthErrorEvent, AuthErrorState> {
  final GlobalAppRouterDelegate _appRouter;

  AuthErrorBloc({
    required AuthErrorType errorType,
    required GlobalAppRouterDelegate appRouter,
  })  : _appRouter = appRouter,
        super(
          AuthErrorState(
            errorType: errorType,
          ),
        ) {
    on<RedirectAction>(_onRedirectAction);
  }

  Future<void> _onRedirectAction(
    RedirectAction event,
    Emitter<AuthErrorState> emit,
  ) async {
    switch (state.errorType) {
      case AuthErrorType.notRegistered:
        _appRouter.popWithResult(true);
        break;
      case AuthErrorType.alreadyRegistered:
        _appRouter.popWithResult(true);
        break;
    }
  }
}
