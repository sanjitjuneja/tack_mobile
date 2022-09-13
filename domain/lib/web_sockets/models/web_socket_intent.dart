part of web_sockets;

class WebSocketIntent<T extends Object> extends Equatable {
  final WebSocketAction action;
  final int objectId;
  final T? object;

  const WebSocketIntent({
    required this.action,
    required this.objectId,
    required this.object,
  });

  @override
  List<Object?> get props => <Object?>[
        action,
        objectId,
        object,
      ];
}
