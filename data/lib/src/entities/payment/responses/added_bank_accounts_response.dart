part of payment_entities;

@JsonSerializable()
class AddedBankAccountsResponse extends JsonSerializable {
  final List<ConnectedBankAccountEntity> results;

  const AddedBankAccountsResponse({
    required this.results,
  });

  factory AddedBankAccountsResponse.fromJson(Map<String, dynamic> json) {
    return _$AddedBankAccountsResponseFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$AddedBankAccountsResponseToJson(this);
}
