import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import 'package:tacks/src/ongoing_tack/ongoing_tacker_tack/bloc/ongoing_tacker_tack_bloc.dart';
import 'package:tacks/src/ongoing_tack/ongoing_tacker_tack/ui/ongoing_tacker_tack_screen.dart';

class OngoingTackerTack {
  static const String routeName = '/ongoingTack';

  static Page<Group> page({
    required Tack tack,
  }) {
    return _OngoingTackerTackPage(tack: tack);
  }
}

class _OngoingTackerTackPage extends Page<Group> {
  final Tack tack;

  @override
  String get name => OngoingTackerTack.routeName;

  const _OngoingTackerTackPage({
    required this.tack,
  });

  @override
  Route<Group> createRoute(BuildContext context) {
    return CupertinoPageRoute<Group>(
      settings: this,
      builder: (_) => BlocProvider<OngoingTackerTackBloc>(
        create: (_) {
          return OngoingTackerTackBloc(
            tack: tack,
            appRouter: AppRouter.of(context),
          );
        },
        child: const OngoingTackerTackScreen(),
      ),
    );
  }
}
