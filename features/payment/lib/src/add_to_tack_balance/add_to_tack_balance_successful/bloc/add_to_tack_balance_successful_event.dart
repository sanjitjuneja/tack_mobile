part of 'add_to_tack_balance_successful_bloc.dart';

abstract class AddToTackBalanceSuccessfulEvent {
  const AddToTackBalanceSuccessfulEvent();
}

class CloseRequest extends AddToTackBalanceSuccessfulEvent {
  const CloseRequest();
}
