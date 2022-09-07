part of 'add_to_tack_balance_bloc.dart';

abstract class AddToTackBalanceEvent {
  const AddToTackBalanceEvent();
}

class InitialLoad extends AddToTackBalanceEvent {
  const InitialLoad();
}

class MakeAddToTackBalanceRequest extends AddToTackBalanceEvent {
  const MakeAddToTackBalanceRequest();
}

class SelectPaymentMethodAction extends AddToTackBalanceEvent {
  const SelectPaymentMethodAction();
}

class UpdateDepositAmountAction extends AddToTackBalanceEvent {
  final double amount;

  const UpdateDepositAmountAction({
    required this.amount,
  });
}

class FetchUserBalanceAction extends AddToTackBalanceEvent {
  const FetchUserBalanceAction();
}

class UserBalanceUpdate extends AddToTackBalanceEvent {
  final UserBankAccount userBalance;

  const UserBalanceUpdate({
    required this.userBalance,
  });
}
