part of user_entities;

@JsonSerializable(createFactory: false)
class DeleteAccountRequest extends JsonSerializable {
  const DeleteAccountRequest();

  @override
  Map<String, dynamic> toJson() => _$DeleteAccountRequestToJson(this);
}
