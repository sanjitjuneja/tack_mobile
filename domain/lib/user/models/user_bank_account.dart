part of user;

class UserBankAccount extends Equatable with IdentifiableMixin {
  final int id;
  final double usdBalance;

  const UserBankAccount({
    required this.id,
    required this.usdBalance,
  });

  @override
  List<Object> get props => <Object>[
        id,
        usdBalance,
      ];

  @override
  int get itemId => id;
}
