part of web_sockets_entities;

enum WebSocketModelEntity {
  @JsonValue('User')
  user,
  @JsonValue('Balance')
  userBalance,
  @JsonValue('GroupTack')
  groupTack,
  @JsonValue('Tack')
  tack,
  @JsonValue('RunnerTack')
  runnerTack,
  @JsonValue('Offer')
  offer,
  @JsonValue('GroupDetails')
  groupDetails,
  @JsonValue('GroupInvitation')
  groupInvitation,
}
