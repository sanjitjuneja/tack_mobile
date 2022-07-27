import 'package:core/core.dart';
import 'package:navigation/navigation.dart';

import '../../../groups.dart';

part 'invitations_event.dart';

part 'invitations_state.dart';

class InvitationsBloc extends Bloc<InvitationsEvent, InvitationsState> {
  final AppRouterDelegate appRouter;

  InvitationsBloc({
    required this.appRouter,
  }) : super(
          const InvitationsState(),
        ) {
    // on<OnOpenDetails>(_onOpenDetails);
    // on<OnJoinGroup>(_onJoinGroup);
  }

  Future<void> _onOpenDetails(
    OnOpenDetails event,
    Emitter<InvitationsState> emit,
  ) async {
    appRouter.push(InvitationDetails.page());
  }

  Future<void> _onJoinGroup(
    OnJoinGroup event,
    Emitter<InvitationsState> emit,
  ) async {}
}
