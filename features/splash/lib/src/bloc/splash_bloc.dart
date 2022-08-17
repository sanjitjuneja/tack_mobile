import 'dart:async';

import 'package:auth/sign_in/sign_in_feature.dart';
import 'package:auth/sign_up/sign_up_feature.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:domain/use_case.dart';
import 'package:flutter/material.dart';
import 'package:home/home.dart';
import 'package:navigation/navigation.dart';

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
        super(SplashContent()) {
    on<InitialEvent>(_onInitialEvent);
    on<SignIn>(_onSignIn);
    on<SignUp>(_onSignUp);
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
      _animateToInitialPosition(event.slidingPanelController);
    }
  }

  Future<void> _onSignIn(
    SignIn event,
    Emitter<SplashState> emit,
  ) async {
    await _animateToEndPosition(event.slidingPanelController);

    final bool? result = await _globalAppRouter.pushForResult(
      SignInFeature.page(),
    );

    if (result == true) {
      _globalAppRouter.replace(FirstRouteFeature.page());
    } else {
      await _animateToInitialPosition(event.slidingPanelController);
    }
  }

  Future<void> _onSignUp(
    SignUp event,
    Emitter<SplashState> emit,
  ) async {
    await _animateToEndPosition(event.slidingPanelController);
    final bool? result = await _globalAppRouter.pushForResult(
      SignUpFeature.page(),
    );

    await _animateToInitialPosition(event.slidingPanelController);
  }

  Future<void> _animateToInitialPosition(
    AnimationController panelController,
  ) async {
    return panelController.animateTo(
      0.3,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  Future<void> _animateToEndPosition(
    AnimationController panelController,
  ) async {
    return panelController.animateTo(
      1.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }
}
