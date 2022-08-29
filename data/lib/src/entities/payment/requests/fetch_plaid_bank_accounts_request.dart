part of payment_entities;

@JsonSerializable(createFactory: false)
class FetchPlaidBankAccountsRequest extends JsonSerializable {
  @JsonKey(name: 'public_token')
  final String publicToken;

  const FetchPlaidBankAccountsRequest({
    required this.publicToken,
  });

  @override
  Map<String, dynamic> toJson() => _$FetchPlaidBankAccountsRequestToJson(this);
}
