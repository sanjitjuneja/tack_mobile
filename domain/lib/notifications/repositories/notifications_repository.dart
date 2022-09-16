part of notifications;

abstract class NotificationsRepository {
  Future<void> initialize();

  Future<void> requestPermissions();

  Future<String?> getToken();

  Future<void> deactivateToken();
}
