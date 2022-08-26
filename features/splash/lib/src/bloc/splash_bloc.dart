import 'dart:async';

import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:domain/use_case.dart';
import 'package:flutter/material.dart';
import 'package:home/home.dart';
import 'package:navigation/navigation.dart';
import 'package:phone_verification/phone_verification.dart';

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
    on<SignIn>(_onSignIn);
    on<SignUp>(_onSignUp);
  }

  Future<void> _onInitialEvent(
    InitialEvent event,
    Emitter<SplashState> emit,
  ) async {
    emit(state.copyWith(slidingPanelController: event.slidingPanelController));

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
    await _animateToEndPosition(state.slidingPanelController!);

    final SignInScreenResult? result = await _globalAppRouter.pushForResult(
      SignInFeature.page(),
    );

    if (result != null) {
      _globalAppRouter.replace(FirstRouteFeature.page());
      if (result == SignInScreenResult.signUp) {
        _globalAppRouter.pushForResult(
          AppAlertDialog.page(
            SuccessAlert(
              contentKey: 'otherAlert.sinUpComplete',
            ),
          ),
        );
      }
    } else {
      await _animateToInitialPosition(state.slidingPanelController!);
    }
  }

  Future<void> _onSignUp(
    SignUp event,
    Emitter<SplashState> emit,
  ) async {
    await _animateToEndPosition(state.slidingPanelController!);
    final PhoneVerificationScreenResult? phoneVerificationScreenResult =
        await _globalAppRouter.pushForResult(
      PhoneVerificationFeature.pageForSignUp(),
    );

    if (phoneVerificationScreenResult != null) {
      if (phoneVerificationScreenResult.shouldOpenSignIn) {
        add(const SignIn());
      } else {
        final bool? result = await _globalAppRouter.pushForResult(
          SignUpFeature.page(
            phoneVerificationData:
                phoneVerificationScreenResult.phoneVerificationData!,
          ),
        );

        if (result == true) {
          _globalAppRouter.replace(FirstRouteFeature.page());
          _globalAppRouter.pushForResult(
            AppAlertDialog.page(
              SuccessAlert(
                contentKey: 'otherAlert.sinUpComplete',
              ),
            ),
          );

          return;
        }
      }
    }

    await _animateToInitialPosition(state.slidingPanelController!);
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
