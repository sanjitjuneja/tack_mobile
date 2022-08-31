part of 'add_to_tack_balance_bloc.dart';

abstract class AddToTackBalanceEvent {
  const AddToTackBalanceEvent();
}

class MakeAddToTackBalanceRequest extends AddToTackBalanceEvent {
  const MakeAddToTackBalanceRequest();
}

class UpdateDepositAmountAction extends AddToTackBalanceEvent {
  final double amount;

  const UpdateDepositAmountAction({
    required this.amount,
  });
}
