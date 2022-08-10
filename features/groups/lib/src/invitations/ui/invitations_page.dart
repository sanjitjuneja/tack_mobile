import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import 'package:groups/src/invitations/bloc/invitations_bloc.dart';
import 'package:groups/src/invitations/ui/invitations_screen.dart';

class InvitationsFeature {
  static const String routeName = '/myInvitations';

  static Page<void> page() {
    return const _InvitationsPage();
  }
}

class _InvitationsPage extends Page<void> {
  @override
  String get name => InvitationsFeature.routeName;

  const _InvitationsPage();

  @override
  Route<void> createRoute(BuildContext context) {
    return CupertinoPageRoute<void>(
      settings: this,
      builder: (_) => BlocProvider<InvitationsBloc>(
        create: (_) {
          return InvitationsBloc(
            appRouter: AppRouter.of(context),
            loadGroupInvitationsUseCase:
                appLocator.get<LoadGroupInvitationsUseCase>(),
            acceptGroupInvitationUseCase:
                appLocator.get<AcceptGroupInvitationUseCase>(),
          );
        },
        child: const InvitationsScreen(),
      ),
    );
  }
}
