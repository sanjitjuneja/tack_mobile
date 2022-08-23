part of 'auth_error_bloc.dart';

abstract class AuthErrorEvent {
  const AuthErrorEvent();
}

class RedirectAction extends AuthErrorEvent {
  final BuildContext context;

  const RedirectAction({
    required this.context,
  });
}
