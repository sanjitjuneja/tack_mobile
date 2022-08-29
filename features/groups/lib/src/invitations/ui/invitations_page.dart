import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import '../bloc/invitations_bloc.dart';
import 'invitations_screen.dart';

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
            fetchGroupInvitationsUseCase:
                appLocator.get<FetchGroupInvitationsUseCase>(),
            acceptGroupInvitationUseCase:
                appLocator.get<AcceptGroupInvitationUseCase>(),
          );
        },
        child: const InvitationsScreen(),
      ),
    );
  }
}
