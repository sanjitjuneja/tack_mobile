part of 'pay_for_tack_bloc.dart';

abstract class PayForTackEvent {
  const PayForTackEvent();
}

class InitialLoad extends PayForTackEvent {
  const InitialLoad();
}

class MakePayForTackRequest extends PayForTackEvent {
  const MakePayForTackRequest();
}

class SelectPaymentMethodAction extends PayForTackEvent {
  const SelectPaymentMethodAction();
}

class UserBalanceUpdate extends PayForTackEvent {
  final UserBankAccount userBalance;

  const UserBalanceUpdate({
    required this.userBalance,
  });
}
