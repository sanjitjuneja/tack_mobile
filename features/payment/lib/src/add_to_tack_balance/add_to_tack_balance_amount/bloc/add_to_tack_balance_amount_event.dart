part of 'add_to_tack_balance_amount_bloc.dart';

abstract class AddToTackBalanceAmountEvent {
  const AddToTackBalanceAmountEvent();
}

class MakeAddToTackBalanceRequest extends AddToTackBalanceAmountEvent {
  const MakeAddToTackBalanceRequest();
}
