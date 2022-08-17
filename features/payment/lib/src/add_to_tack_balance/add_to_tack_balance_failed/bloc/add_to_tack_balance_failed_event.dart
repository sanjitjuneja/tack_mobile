part of 'add_to_tack_balance_failed_bloc.dart';

abstract class AddToTackBalanceFailedEvent {
  const AddToTackBalanceFailedEvent();
}

class CloseRequest extends AddToTackBalanceFailedEvent {
  const CloseRequest();
}
