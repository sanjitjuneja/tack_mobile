part of user;

class UserBankAccount extends Equatable {
  final double usdBalance;

  const UserBankAccount({
    required this.usdBalance,
  });

  @override
  List<Object> get props => <Object>[
        usdBalance,
      ];
}
