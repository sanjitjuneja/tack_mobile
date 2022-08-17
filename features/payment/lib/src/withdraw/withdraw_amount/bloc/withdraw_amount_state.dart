part of 'withdraw_amount_bloc.dart';

class WithdrawAmountState {
  final WithdrawMethodType withdrawMethodType;

  const WithdrawAmountState({
    required this.withdrawMethodType,
  });

  WithdrawAmountState copyWith({
    WithdrawMethodType? withdrawMethodType,
    String? withdrawAmount,
  }) {
    return WithdrawAmountState(
      withdrawMethodType: withdrawMethodType ?? this.withdrawMethodType,
    );
  }
}
