part of 'withdraw_bloc.dart';

class WithdrawState {
  final WithdrawMethodType withdrawMethodType;

  const WithdrawState({
    required this.withdrawMethodType,
  });

  WithdrawState copyWith({
    WithdrawMethodType? withdrawMethodType,
    String? withdraw,
  }) {
    return WithdrawState(
      withdrawMethodType: withdrawMethodType ?? this.withdrawMethodType,
    );
  }
}