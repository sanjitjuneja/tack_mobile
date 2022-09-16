part of notifications;

class RequestNotificationsPermissionsUseCase
    extends FutureUseCase<void, NoParams> {
  final NotificationsRepository _notificationsRepository;

  RequestNotificationsPermissionsUseCase({
    required NotificationsRepository notificationsRepository,
  }) : _notificationsRepository = notificationsRepository;

  @override
  Future<void> execute(NoParams params) async {
    return _notificationsRepository.requestPermissions();
  }
}
