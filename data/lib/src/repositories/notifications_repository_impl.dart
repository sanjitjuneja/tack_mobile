import 'package:core/core.dart';
import 'package:domain/domain.dart';

class NotificationsRepositoryImpl extends NotificationsRepository {
  static const AndroidNotificationChannel _androidChannel =
      AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.max,
  );

  FirebaseMessaging? _fcm;
  FlutterLocalNotificationsPlugin? _flutterLocalNotificationsPlugin;

  Future<bool> get _isFCMSupported => _fcm!.isSupported();

  @override
  Future<void> initialize() async {
    await _initializeRemoteNotifications();
  }

  Future<void> _initializeRemoteNotifications() async {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _fcm = FirebaseMessaging.instance;

    if (!await _isFCMSupported) return;

    await _fcm!.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await _flutterLocalNotificationsPlugin!
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_androidChannel);

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        final RemoteNotification? notification = message.notification;

        if (notification != null) {
          _showNotification(notification);
        }
      },
    );
  }

  @override
  Future<void> requestPermissions() async {
    assert(_fcm != null, 'NotificationsRepository.initialize() should be called before using FCM');

    if (!await _isFCMSupported) return;

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
    assert(_fcm != null, 'NotificationsRepository.initialize() should be called before using FCM');

    if (!await _isFCMSupported) return null;

    return _fcm!.getToken();
  }

  @override
  Future<void> deactivateToken() async {
    assert(_fcm != null, 'NotificationsRepository.initialize() should be called before using FCM');

    if (!await _isFCMSupported) return;

    await _fcm!.deleteToken();
  }

  Future<void> _showNotification(RemoteNotification notification) async {
    final String? title = notification.title;
    final String? body = notification.body;
    if (title == null || body == null) return;

    final AndroidNotification? android = notification.android;

    if (android != null) {
      _flutterLocalNotificationsPlugin!.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            icon: android.smallIcon,
            // other properties...
          ),
        ),
      );
    }
  }
}
