import 'dart:async';

import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:home/dashboard/bloc/dashboard_state.dart';

import '../mocked_data/private_room_data.dart';
import '../mocked_data/public_room_data.dart';
import '../mocked_data/user_data.dart';
import 'dashboard_event.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardLoading()) {
    add(DashboardLoadData());
  }

  late UserModel user;
  bool isPublicTabOpened = true;
  List<TackListModel> privatTacks = [];
  List<TackListModel> publicTacks = [];

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    if (event is DashboardLoadData) {
      user = userDemoModel;
      privatTacks = getPrivatTacks();
      publicTacks = getPublicTacks();

      yield DashboardContent(
        user: user,
        isPublicTabOpened: isPublicTabOpened,
        tacksList: isPublicTabOpened ? publicTacks : privatTacks,
      );
    }

    if (event is ChangeRoom) {
      isPublicTabOpened = !isPublicTabOpened;

      yield DashboardContent(
        user: user,
        isPublicTabOpened: isPublicTabOpened,
        tacksList: isPublicTabOpened ? publicTacks : privatTacks,
      );
    }
  }
}
