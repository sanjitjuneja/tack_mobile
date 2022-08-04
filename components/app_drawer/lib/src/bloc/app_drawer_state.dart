part of 'app_drawer_bloc.dart';

class AppDrawerState {
  final User user;

  const AppDrawerState({
    required this.user,
  });

  AppDrawerState copyWith({
    User? user,
  }) {
    return AppDrawerState(
      user: user ?? this.user,
    );
  }
}
