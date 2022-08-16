part of 'withdraw_successful_bloc.dart';

abstract class WithdrawSuccessfulEvent {
  const WithdrawSuccessfulEvent();
}

class CloseRequest extends WithdrawSuccessfulEvent {
  const CloseRequest();
}
