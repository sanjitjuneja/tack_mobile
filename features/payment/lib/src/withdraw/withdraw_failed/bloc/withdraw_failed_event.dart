part of 'withdraw_failed_bloc.dart';

abstract class WithdrawFailedEvent {
  const WithdrawFailedEvent();
}

class CloseRequest extends WithdrawFailedEvent {
  const CloseRequest();
}
