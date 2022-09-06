import 'dart:async';

import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:domain/use_case.dart';
import 'package:flutter/material.dart';
import 'package:home/home.dart';
import 'package:navigation/navigation.dart';
import 'package:onboarding/onboarding.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final GlobalAppRouterDelegate _globalAppRouter;
  final IsAuthorizedUseCase _isAuthorizedUseCase;

  SplashBloc({
    required GlobalAppRouterDelegate globalAppRouter,
    required IsAuthorizedUseCase isAuthorizedUseCase,
  })  : _globalAppRouter = globalAppRouter,
        _isAuthorizedUseCase = isAuthorizedUseCase,
        super(const SplashState()) {
    on<InitialEvent>(_onInitialEvent);

    add(const InitialEvent());
  }

  Future<void> _onInitialEvent(
    InitialEvent event,
    Emitter<SplashState> emit,
  ) async {
    final bool isAuthorized = await _isAuthorizedUseCase.execute(NoParams());

    if (isAuthorized) {
      await dataDI.setupPostLoginAppLocator();
      _globalAppRouter.replace(
        FirstRouteFeature.page(
          withSlideAnimation: false,
        ),
      );
    } else {
      _globalAppRouter.replace(OnboardingFeature.page());
    }
  }
}
