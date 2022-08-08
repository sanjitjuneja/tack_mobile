part of 'app_drawer_bloc.dart';

abstract class AppDrawerEvent {
  const AppDrawerEvent();
}

class UserUpdate extends AppDrawerEvent {
  final User user;

  const UserUpdate({
    required this.user,
  });
}

class GoTo extends AppDrawerEvent {
  final BuildContext context;
  final GoToOption goTo;

  const GoTo(
    this.context,
    this.goTo,
  );
}

class LogOut extends AppDrawerEvent {
  const LogOut();
}
