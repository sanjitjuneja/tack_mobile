part of payment_entities;

@JsonSerializable(createFactory: false)
class GetAddedBankAccountRequest extends JsonSerializable {
  @JsonKey(name: 'public_token')
  final String publicToken;

  const GetAddedBankAccountRequest({
    required this.publicToken,
  });

  @override
  Map<String, dynamic> toJson() => _$GetAddedBankAccountRequestToJson(this);
}
