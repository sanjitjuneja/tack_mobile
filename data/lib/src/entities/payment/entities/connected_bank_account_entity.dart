part of payment_entities;

@JsonSerializable(createToJson: false)
class ConnectedBankAccountEntity extends JsonSerializable {
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
  @JsonKey(name: 'image')
  final String? imageUrl;
  @JsonKey(name: 'channels')
  final List<String> channels;

  const ConnectedBankAccountEntity({
    required this.id,
    required this.bankName,
    required this.status,
    required this.type,
    required this.bankAccountType,
    required this.imageUrl,
    required this.channels,
  });

  factory ConnectedBankAccountEntity.fromJson(Map<String, dynamic> json) {
    return _$ConnectedBankAccountEntityFromJson(json);
  }
}
