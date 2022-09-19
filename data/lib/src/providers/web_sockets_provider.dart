import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:core/core.dart';
import 'package:domain/domain.dart' as domain;
import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/io.dart' as ws;
import 'package:web_socket_channel/status.dart' as status;

import '../entities/entities.dart';
import '../mappers/mappers.dart';
import 'session_provider.dart';
import 'web_sockets_handlers.dart';

class WebSocketsProvider with WebSocketHandlers, WidgetsBindingObserver {
  static const String _deviceInfoHeader = 'device-info';
  static const Duration _pingIntervalDuration = Duration(seconds: 30);
  static const Duration _autoReconnectDuration = Duration(milliseconds: 3000);
  static const Duration _autoDisconnectDuration = Duration(seconds: 120);

  final AppConfig _appConfig;
  final SessionProvider _sessionProvider;
  final MapperFactory _mapper;

  ws.IOWebSocketChannel? socketChannel;
  StreamSubscription? listener;

  Timer? _reconnectTimer;
  Timer? _autoDisconnectTimer;

  WebSocketsProvider({
    required AppConfig appConfig,
    required SessionProvider sessionProvider,
    required MapperFactory mapper,
  })  : _appConfig = appConfig,
        _sessionProvider = sessionProvider,
        _mapper = mapper {
    WidgetsBinding.instance.addObserver(this);
    initStreams();
    connect();
  }

  void _onMessageReceived(dynamic message) {
    final WebSocketMessage webSocketMessage = WebSocketMessage.fromJson(
      jsonDecode(message as String),
    );
    socketChannel?.sink.add(webSocketMessage.model.name);

    switch (webSocketMessage.model) {
      case WebSocketModelEntity.user:
        return _parseDataAndAddToStream<UserEntity, domain.User>(
          json: webSocketMessage.message,
          streamController: userController,
        );
      case WebSocketModelEntity.userBalance:
        return _parseDataAndAddToStream<UserBankAccountEntity,
            domain.UserBankAccount>(
          json: webSocketMessage.message,
          streamController: userBalanceController,
        );
      case WebSocketModelEntity.groupTack:
        return _parseDataAndAddToStream<GroupTackEntity, domain.GroupTack>(
          json: webSocketMessage.message,
          streamController: groupTacksController,
        );
      case WebSocketModelEntity.tack:
        return _parseDataAndAddToStream<TackEntity, domain.Tack>(
          json: webSocketMessage.message,
          streamController: tacksController,
        );
      case WebSocketModelEntity.runnerTack:
        return _parseDataAndAddToStream<RunnerTackEntity, domain.RunnerTack>(
          json: webSocketMessage.message,
          streamController: runnerTacksController,
        );
      case WebSocketModelEntity.completedTackRunner:
        return _parseDataAndAddToStream<TackEntity, domain.Tack>(
          json: webSocketMessage.message,
          streamController: competedTacksRunnerController,
        );
      case WebSocketModelEntity.cancelTackerTackRunner:
        return _parseDataAndAddToStream<TackEntity, domain.Tack>(
          json: webSocketMessage.message,
          streamController: cancelTackerTacksRunnerController,
        );
      case WebSocketModelEntity.offer:
        return _parseDataAndAddToStream<OfferEntity, domain.Offer>(
          json: webSocketMessage.message,
          streamController: offersController,
        );
      case WebSocketModelEntity.groupDetails:
        return _parseDataAndAddToStream<GroupDetailsEntity,
            domain.GroupDetails>(
          json: webSocketMessage.message,
          streamController: groupsController,
        );
      case WebSocketModelEntity.groupInvitation:
        return _parseDataAndAddToStream<GroupInvitationEntity,
            domain.GroupInvitation>(
          json: webSocketMessage.message,
          streamController: groupInvitationsController,
        );
    }
  }

  Future<void> connect() async {
    if (socketChannel?.innerWebSocket?.readyState == WebSocket.open) return;

    try {
      final Session? session = await _sessionProvider.getCurrentSession();
      if (session == null) throw Exception('no session found');

      final String deviceInfo = <String?>{
        await PlatformInfoManager.getDeviceModel(),
        await PlatformInfoManager.getDeviceId(),
      }.join(' - ');

      socketChannel = ws.IOWebSocketChannel.connect(
        _appConfig.webSocketsUrl,
        pingInterval: _pingIntervalDuration,
        headers: <String, dynamic>{
          HttpHeaders.authorizationHeader: session.accessToken,
          _deviceInfoHeader: deviceInfo,
        },
      );
      listener = socketChannel!.stream.listen(
        _onMessageReceived,
        onDone: () {
          _reconnectTimer ??= Timer(_autoReconnectDuration, reconnect);
        },
        onError: (_) {
          _reconnectTimer ??= Timer(_autoReconnectDuration, reconnect);
        },
      );

      socketChannel!.sink.add('Web socket is Connected -- ${DateTime.now()}');
    } catch (e) {
      await Future.delayed(_autoReconnectDuration);
      connect();
    }
  }

  Future<void> _disconnect() async {
    socketChannel?.sink.add('Web socket is Disconnecting -- ${DateTime.now()}');
    _removeAutReconnect();

    await listener?.cancel();
    listener = null;

    if (socketChannel?.innerWebSocket?.readyState == WebSocket.open) {
      await socketChannel?.sink.close(status.goingAway);
    }
    socketChannel = null;
  }

  Future<void> reconnect() async {
    await _disconnect();
    await connect();
  }

  void _parseDataAndAddToStream<T, D extends IdentifiableMixin>({
    required Map<String, dynamic> json,
    required WebSocketStreamController<D> streamController,
  }) {
    try {
      final WebSocketIntentEntity<T> intentEntity =
      WebSocketIntentEntity<T>.fromJson(json);

      final domain.WebSocketIntent<D> intent =
      _mapper.webSocketIntentMapper<T, D>().fromEntity(intentEntity);
      streamController.add(intent);

      socketChannel?.sink.add(
        jsonEncode(
          <String, dynamic>{
            'action': intent.action.name,
            'id': intent.objectId,
            'hasObject': intent.object != null,
            'objectId': intent.object?.itemId,
          },
        ),
      );
    } catch (e) {
      socketChannel?.sink.add(
        jsonEncode(
          <String, dynamic>{
            'entity': D,
            'error': e,
          },
        ),
      );
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      _removeAutoDisconnect();
      _disconnect();
    } else if (state == AppLifecycleState.resumed) {
      _removeAutoDisconnect();
      connect();
    } else if (state == AppLifecycleState.paused) {
      _autoDisconnectTimer = Timer(
        _autoDisconnectDuration,
        _disconnect,
      );
    }

    super.didChangeAppLifecycleState(state);
  }

  void _removeAutReconnect() {
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
  }

  void _removeAutoDisconnect() {
    _autoDisconnectTimer?.cancel();
    _autoDisconnectTimer = null;
  }

  Future<void> dispose() async {
    socketChannel?.sink.add(
      'Web socket Dispose on Log out -- ${DateTime.now()}',
    );
    _removeAutoDisconnect();
    _removeAutReconnect();
    await _disconnect();
    close();
  }
}
