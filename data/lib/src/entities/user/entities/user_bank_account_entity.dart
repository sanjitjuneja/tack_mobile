part of user_entities;

@JsonSerializable()
class UserBankAccountEntity extends JsonSerializable {
  final int user;
  @JsonKey(name: 'usd_balance')
  final int usdBalance;

  const UserBankAccountEntity({
    required this.user,
    required this.usdBalance,
  });

  factory UserBankAccountEntity.fromJson(Map<String, dynamic> json) {
    return _$UserBankAccountEntityFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$UserBankAccountEntityToJson(this);
}