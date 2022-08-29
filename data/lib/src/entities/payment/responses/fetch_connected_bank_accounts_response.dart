part of payment_entities;

@JsonSerializable()
class FetchConnectedBankAccountsResponse extends JsonSerializable {
  final List<ConnectedBankAccountEntity> results;

  const FetchConnectedBankAccountsResponse({
    required this.results,
  });

  factory FetchConnectedBankAccountsResponse.fromJson(
      Map<String, dynamic> json) {
    return _$FetchConnectedBankAccountsResponseFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() =>
      _$FetchConnectedBankAccountsResponseToJson(this);
}
