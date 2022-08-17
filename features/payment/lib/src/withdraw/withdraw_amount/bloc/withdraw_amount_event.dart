part of 'withdraw_amount_bloc.dart';

abstract class WithdrawAmountEvent {
  const WithdrawAmountEvent();
}

class ChangeWithdrawAmountMethodTypeRequest extends WithdrawAmountEvent {
  const ChangeWithdrawAmountMethodTypeRequest();
}

class MakeWithdrawAmountRequest extends WithdrawAmountEvent {
  const MakeWithdrawAmountRequest();
}
