import 'dart:async';

import 'package:auth/sign_in/sign_in_feature.dart';
import 'package:auth/sign_up/sign_up_feature.dart';
import 'package:core/core.dart';
import 'package:navigation/navigation.dart';
import 'package:splash/bloc/splash_event.dart';
import 'package:splash/bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final AppRouterDelegate appRouter;

  SplashBloc({
    required this.appRouter,
  }) : super(SplashContent());

  @override
  Stream<SplashState> mapEventToState(SplashEvent event) async* {
    if (event is SignIn) {
      final bool? result = await appRouter.pushForResult(
        SignInFeature.page(),
      );

      yield (SplashContent(
        needToBackAnimation: result,
      ));
    }

    if (event is SignUp) {
      final bool? result = await appRouter.pushForResult(
        SignUpFeature.page(),
      );

      yield (SplashContent(
        needToBackAnimation: result,
      ));
    }
  }
}
