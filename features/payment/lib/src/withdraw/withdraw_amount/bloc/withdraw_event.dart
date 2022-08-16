part of 'withdraw_bloc.dart';

abstract class WithdrawEvent {
  const WithdrawEvent();
}

class ChangeWithdrawMethodTypeRequest extends WithdrawEvent {
  const ChangeWithdrawMethodTypeRequest();
}

class MakeWithdrawRequest extends WithdrawEvent {
  const MakeWithdrawRequest();
}
