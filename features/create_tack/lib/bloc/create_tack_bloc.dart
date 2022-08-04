import 'dart:async';

import 'package:core/core.dart';
import 'package:navigation/navigation.dart';

import 'create_tack_event.dart';
import 'create_tack_state.dart';

class CreateTackBloc extends Bloc<CreateTackEvent, CreateTackState> {
  final AppRouterDelegate appRouter;

  CreateTackBloc({
    required this.appRouter,
  }) : super(CreateTackContent());

  @override
  Stream<CreateTackState> mapEventToState(CreateTackEvent event) async* {
    if (event is CreateTack) {}
  }
}
