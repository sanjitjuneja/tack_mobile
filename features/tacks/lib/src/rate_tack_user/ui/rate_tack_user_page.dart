import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import 'package:tacks/src/rate_tack_user/bloc/rate_tack_user_bloc.dart';
import 'package:tacks/src/rate_tack_user/ui/rate_tack_user_screen.dart';

class RateTackUser {
  static const String routeName = '/rateTackUser';

  static Page<bool> page({
    required Tack tack,
    required TackUser tackUser,
  }) {
    return _RateTackUserPage(
      tack: tack,
      tackUser: tackUser,
    );
  }
}

class _RateTackUserPage extends Page<bool> {
  final Tack tack;
  final TackUser tackUser;

  @override
  String get name => RateTackUser.routeName;

  const _RateTackUserPage({
    required this.tack,
    required this.tackUser,
  });

  @override
  Route<bool> createRoute(BuildContext context) {
    return CupertinoPageRoute<bool>(
      fullscreenDialog: true,
      settings: this,
      builder: (_) => BlocProvider<RateTackUserBloc>(
        create: (_) {
          return RateTackUserBloc(
            tack: tack,
            tackUser: tackUser,
            appRouter: AppRouter.of(context),
            rateTackUseCase: appLocator.get<RateTackUseCase>(),
          );
        },
        child: const RateTackUserScreen(),
      ),
    );
  }
}
