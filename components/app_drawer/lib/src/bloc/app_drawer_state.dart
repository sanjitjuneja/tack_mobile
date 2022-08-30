part of 'app_drawer_bloc.dart';

class AppDrawerState {
  final User user;
  final UserBankAccount userBalance;

  const AppDrawerState({
    required this.user,
    required this.userBalance,
  });

  AppDrawerState copyWith({
    User? user,
    UserBankAccount? userBalance,
  }) {
    return AppDrawerState(
      user: user ?? this.user,
      userBalance: userBalance ?? this.userBalance,
    );
  }
}
