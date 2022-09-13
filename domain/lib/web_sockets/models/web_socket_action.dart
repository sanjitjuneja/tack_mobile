part of web_sockets;

enum WebSocketAction {
  create,
  update,
  delete;

  bool get isCreate => this == WebSocketAction.create;

  bool get isUpdate => this == WebSocketAction.update;

  bool get isDelete => this == WebSocketAction.delete;
}
