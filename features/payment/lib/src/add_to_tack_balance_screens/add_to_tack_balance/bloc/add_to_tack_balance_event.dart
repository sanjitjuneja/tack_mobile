part of 'add_to_tack_balance_bloc.dart';

abstract class AddToTackBalanceEvent {
  const AddToTackBalanceEvent();
}

class MakeAddToTackBalanceRequest extends AddToTackBalanceEvent {
  const MakeAddToTackBalanceRequest();
}
