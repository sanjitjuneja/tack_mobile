import 'package:domain/domain.dart';

abstract class DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardContent extends DashboardState {
  final UserModel user;
  final bool isPublicTabOpened;
  final List<TackListModel> tacksList;

  DashboardContent({
    required this.user,
    required this.tacksList,
    required this.isPublicTabOpened,
  });
}

class DashboardError extends DashboardState {}
