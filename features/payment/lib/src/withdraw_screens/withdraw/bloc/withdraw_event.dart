part of 'withdraw_bloc.dart';

abstract class WithdrawEvent {
  const WithdrawEvent();
}

class InitialLoad extends WithdrawEvent {
  const InitialLoad();
}

class SelectBankAccountAction extends WithdrawEvent {
  const SelectBankAccountAction();
}

class UserBalanceUpdate extends WithdrawEvent {
  final UserBankAccount userBalance;

  const UserBalanceUpdate({
    required this.userBalance,
  });
}

class UpdateWithdrawAmountAction extends WithdrawEvent {
  final double withdrawAmount;

  const UpdateWithdrawAmountAction({
    required this.withdrawAmount,
  });
}

class MakeWithdrawRequest extends WithdrawEvent {
  const MakeWithdrawRequest();
}
