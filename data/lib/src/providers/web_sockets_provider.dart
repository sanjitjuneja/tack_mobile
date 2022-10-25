import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:core/core.dart';
import 'package:domain/domain.dart' as domain;
import 'package:web_socket_channel/io.dart' as ws;
import 'package:web_socket_channel/status.dart' as status;

import 'session_provider.dart';
import 'web_sockets_handlers.dart';
import '../entities/entities.dart';
import '../mappers/mappers.dart';

class WebSocketsProvider with WebSocketHandlers, domain.AppLifeCycleObserver {
  static const String _deviceInfoHeader = 'device-info';
  static const Duration _pingIntervalDuration = Duration(seconds: 30);
  static const Duration _autoReconnectDuration = Duration(milliseconds: 3000);

  final AppConfig _appConfig;
  final SessionProvider _sessionProvider;
  final MapperFactory _mapper;
  final domain.AppLifeCycleProvider _appLifeCycleProvider;

  ws.IOWebSocketChannel? socketChannel;
  StreamSubscription? listener;

  Timer? _reconnectTimer;

  WebSocketsProvider({
    required AppConfig appConfig,
    required SessionProvider sessionProvider,
    required MapperFactory mapper,
    required domain.AppLifeCycleProvider appLifeCycleProvider,
  })  : _appConfig = appConfig,
        _sessionProvider = sessionProvider,
        _mapper = mapper,
        _appLifeCycleProvider = appLifeCycleProvider {
    _appLifeCycleProvider.addObserver(this);
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
      default:
        return;
    }
  }

  Future<void> connect() async {
    final int? webSocketState = socketChannel?.innerWebSocket?.readyState;
    if (webSocketState == WebSocket.open ||
        webSocketState == WebSocket.connecting) {
      return;
    }
    listener?.cancel();

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
        }..addAll(_appConfig.flavorHeader),
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

      socketChannel!.sink.add(
        'Web socket is Connected -- ${DateTime.now().toUtc()}',
      );
    } catch (e) {
      await Future.delayed(_autoReconnectDuration);
      reconnect();
    }
  }

  Future<void> _disconnect() async {
    socketChannel?.sink.add(
      'Web socket is Disconnecting -- ${DateTime.now().toUtc()}',
    );
    _removeAutoReconnect();

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
            'entity': D.toString(),
            'error': e.toString(),
          },
        ),
      );
    }
  }

  void _removeAutoReconnect() {
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
  }

  @override
  void onShouldRefresh() {
    connect();
  }

  @override
  void onShouldSleep() {
    _disconnect();
  }

  @override
  void onShouldDispose() {
    dispose();
  }

  Future<void> dispose() async {
    socketChannel?.sink.add(
      'Web socket Dispose on Log out -- ${DateTime.now().toUtc()}',
    );
    _removeAutoReconnect();
    await _disconnect();
    close();
    _appLifeCycleProvider.removeObserver(this);
  }
}
