import 'dart:io';
import 'dart:ui';

import 'package:core/core.dart';
import 'package:domain/domain.dart';

class NotificationsRepositoryImpl extends NotificationsRepository {
  static final NotificationChannel _androidChannel = NotificationChannel(
    channelKey: 'high_importance_channel',
    // id
    channelName: 'High Importance Notifications',
    // title
    channelDescription: 'Tack notifications',
    playSound: true,
    importance: NotificationImportance.Max,
    defaultColor: const Color(0xFF54BCA0),
  );

  FirebaseMessaging? _fcm;
  AwesomeNotifications? _flutterLocalNotificationsPlugin;

  Future<bool> get _isFCMSupported => _fcm!.isSupported();

  @override
  Future<void> initialize() async {
    await _initializeRemoteNotifications();
  }

  Future<void> _initializeRemoteNotifications() async {
    _flutterLocalNotificationsPlugin = AwesomeNotifications();
    _fcm = FirebaseMessaging.instance;

    if (!await _isFCMSupported) return;

    await _fcm!.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await _flutterLocalNotificationsPlugin!.initialize(
      'resource://drawable/ic_notification',
      <NotificationChannel>[
        _androidChannel,
      ],
    );

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        if (Platform.isIOS) return;

        final RemoteNotification? notification = message.notification;
        if (notification != null) {
          _showNotification(notification);
        }
      },
    );
  }

  @override
  Future<void> requestPermissions() async {
    assert(_fcm != null,
        'NotificationsRepository.initialize() should be called before using FCM');

    if (!await _isFCMSupported) return;

    await _flutterLocalNotificationsPlugin!
        .requestPermissionToSendNotifications();
    await _fcm!.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  @override
  Future<String?> getToken() async {
    assert(_fcm != null,
        'NotificationsRepository.initialize() should be called before using FCM');

    if (!await _isFCMSupported) return null;

    return _fcm!.getToken();
  }

  @override
  Future<void> deactivateToken() async {
    assert(_fcm != null,
        'NotificationsRepository.initialize() should be called before using FCM');

    if (!await _isFCMSupported) return;

    await _fcm!.deleteToken();
  }

  Future<bool> _showNotification(RemoteNotification notification) async {
    final String? title = notification.title;
    final String? body = notification.body;
    if (title == null || body == null) return false;

    String? imageUrl;
    imageUrl ??= notification.android?.imageUrl;
    imageUrl ??= notification.apple?.imageUrl;

    return AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 0,
        channelKey: _androidChannel.channelKey!,
        title: notification.title,
        body: notification.body,
        notificationLayout: AwesomeStringUtils.isNullOrEmpty(imageUrl)
            ? NotificationLayout.Default
            : NotificationLayout.BigPicture,
        bigPicture: imageUrl,
      ),
    );
  }
}
