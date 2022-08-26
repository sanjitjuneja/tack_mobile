part of payment_entities;

@JsonSerializable()
class GetConnectedBankAccountsResponse extends JsonSerializable {
  final List<ConnectedBankAccountEntity> results;

  const GetConnectedBankAccountsResponse({
    required this.results,
  });

  factory GetConnectedBankAccountsResponse.fromJson(Map<String, dynamic> json) {
    return _$GetConnectedBankAccountsResponseFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() =>
      _$GetConnectedBankAccountsResponseToJson(this);
}
