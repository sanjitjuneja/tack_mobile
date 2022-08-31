part of 'add_to_tack_balance_bloc.dart';

class AddToTackBalanceState {
  final double amount;

  const AddToTackBalanceState({
    required this.amount,
  });

  AddToTackBalanceState copyWith({
    double? amount,
  }) {
    return AddToTackBalanceState(
      amount: amount ?? this.amount,
    );
  }
}
