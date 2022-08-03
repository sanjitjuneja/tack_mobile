import 'dart:async';

import 'package:auth/sign_in/sign_in_feature.dart';
import 'package:auth/sign_up/sign_up_feature.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:domain/use_case.dart';
import 'package:flutter/material.dart';
import 'package:home/home.dart';
import 'package:navigation/navigation.dart';
import 'package:splash/bloc/splash_event.dart';
import 'package:splash/bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final AppRouterDelegate _appRouter;
  final IsAuthorizedUseCase _isAuthorizedUseCase;

  SplashBloc({
    required AppRouterDelegate appRouter,
    required IsAuthorizedUseCase isAuthorizedUseCase,
  })  : _appRouter = appRouter,
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
    /// TODO: uncomment (leave it until Logout functionality not implemented)
    // final bool isAuthorized = await _isAuthorizedUseCase.execute(NoParams());
    //
    // if (isAuthorized) {
    //   await _animateToEndPosition(event.slidingPanelController);
    //
    //   _appRouter.replace(HomePage());
    // } else {
      _animateToInitialPosition(event.slidingPanelController);
    // }
  }

  Future<void> _onSignIn(
    SignIn event,
    Emitter<SplashState> emit,
  ) async {
    await _animateToEndPosition(event.slidingPanelController);

    final bool? result = await _appRouter.pushForResult(
      SignInFeature.page(),
    );

    if (result == true) {
      _appRouter.replace(HomePage());
    } else {
      await _animateToInitialPosition(event.slidingPanelController);
    }
  }

  Future<void> _onSignUp(
    SignUp event,
    Emitter<SplashState> emit,
  ) async {
    await _animateToEndPosition(event.slidingPanelController);
    final bool? result = await _appRouter.pushForResult(
      SignUpFeature.page(),
    );

    if (result == true) {
      await dataDI.setupPostLoginAppLocator();
      _appRouter.replace(HomePage());
    } else {
      await _animateToInitialPosition(event.slidingPanelController);
    }
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
