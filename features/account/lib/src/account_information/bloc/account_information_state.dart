part of 'account_information_bloc.dart';

class AccountInformationState {
  final User user;

  const AccountInformationState({
    required this.user,
  });

  AccountInformationState copyWith({
    User? user,
  }) {
    return AccountInformationState(
      user: user ?? this.user,
    );
  }
}
