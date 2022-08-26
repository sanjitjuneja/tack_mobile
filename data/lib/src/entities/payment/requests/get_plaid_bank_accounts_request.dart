part of payment_entities;

@JsonSerializable(createFactory: false)
class GetPlaidBankAccountsRequest extends JsonSerializable {
  @JsonKey(name: 'public_token')
  final String publicToken;

  const GetPlaidBankAccountsRequest({
    required this.publicToken,
  });

  @override
  Map<String, dynamic> toJson() => _$GetPlaidBankAccountsRequestToJson(this);
}
