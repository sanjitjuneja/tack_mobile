import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:core/core.dart';
import 'package:domain/domain.dart' as domain;
import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/status.dart' as status;

import '../entities/entities.dart';
import '../mappers/mappers.dart';
import 'session_provider.dart';
import 'web_sockets_handlers.dart';

class WebSocketsProvider with WebSocketHandlers, WidgetsBindingObserver {
  static const Duration autoReconnectDuration = Duration(milliseconds: 10000);

  final AppConfig _appConfig;
  final SessionProvider _sessionProvider;
  final MapperFactory _mapper;

  WebSocket? socketChannel;
  StreamSubscription? listener;

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
    try {
      final Session? session = await _sessionProvider.getCurrentSession();
      if (session == null) throw Exception('no session found');

      socketChannel = await WebSocket.connect(
        _appConfig.webSocketsUrl,
        headers: <String, dynamic>{
          HttpHeaders.authorizationHeader: session.accessToken,
        },
      );
      listener = socketChannel!.listen(
        _onMessageReceived,
        onDone: () {
          reconnect();
        },
        onError: (_) {
          reconnect();
        },
      );
    } catch (e) {
      await Future.delayed(autoReconnectDuration);
      reconnect();
    }
  }

  Future<void> _disconnect() async {
    await listener?.cancel();
    listener = null;

    await socketChannel?.close(status.goingAway);
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
    final WebSocketIntentEntity<T> intentEntity =
        WebSocketIntentEntity<T>.fromJson(json);

    final domain.WebSocketIntent<D> intent =
        _mapper.webSocketIntentMapper<T, D>().fromEntity(intentEntity);
    streamController.add(intent);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      connect();
    } else if (state == AppLifecycleState.paused) {
      _disconnect();
    } else if (state == AppLifecycleState.detached) {
      _disconnect();
      close();
    }

    super.didChangeAppLifecycleState(state);
  }

  Future<void> dispose() async {
    await _disconnect();
    close();
  }
}
