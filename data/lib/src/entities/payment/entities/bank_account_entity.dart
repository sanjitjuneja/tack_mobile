part of payment_entities;

@JsonSerializable(createToJson: false)
class BankAccountEntity extends JsonSerializable {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'bankName')
  final String bankName;
  @JsonKey(name: 'status')
  final String status;
  @JsonKey(name: 'type')
  final String type;
  @JsonKey(name: 'bankAccountType')
  final String bankAccountType;
  @JsonKey(name: 'channels')
  final List<String> channels;

  const BankAccountEntity({
    required this.id,
    required this.bankName,
    required this.status,
    required this.type,
    required this.bankAccountType,
    required this.channels,
  });

  factory BankAccountEntity.fromJson(Map<String, dynamic> json) {
    return _$BankAccountEntityFromJson(json);
  }
}
