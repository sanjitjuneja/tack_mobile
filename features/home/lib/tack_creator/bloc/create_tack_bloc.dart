import 'dart:async';

import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:home/tack_creator/bloc/create_tack_event.dart';
import 'package:home/tack_creator/bloc/create_tack_state.dart';

import '../mocked_data/create_tack_data.dart';

class CreateTackBloc extends Bloc<CreateTackEvent, CreateTackState> {
  CreateTackBloc() : super(CreateTackLoading()) {
    add(CreateTackLoadData());
  }

  bool isPopularTabOpened = true;
  List<CreateTackModel> popularTacks = [];
  List<CreateTackModel> savedTacks = [];

  @override
  Stream<CreateTackState> mapEventToState(CreateTackEvent event) async* {
    if (event is CreateTackLoadData) {
      popularTacks = getCreateTackList();
      savedTacks = getSavedTacks();

      yield CreateTackContent(
        isPopularTabOpened: isPopularTabOpened,
        tacks: isPopularTabOpened ? popularTacks : savedTacks,
      );
    }

    if (event is ChangeRoom) {
      isPopularTabOpened = !isPopularTabOpened;

      yield CreateTackContent(
        isPopularTabOpened: isPopularTabOpened,
        tacks: isPopularTabOpened ? popularTacks : savedTacks,
      );
    }
  }

  List<CreateTackModel> getSavedTacks() {
    return popularTacks
        .where((element) => element.isSavedTack == true)
        .toList();
  }
}
