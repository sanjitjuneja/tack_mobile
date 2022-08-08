import 'package:flutter/cupertino.dart';

abstract class SplashEvent {
  const SplashEvent();
}

class InitialEvent extends SplashEvent {
  final AnimationController slidingPanelController;

  const InitialEvent(this.slidingPanelController);
}

class SignIn extends SplashEvent {
  final AnimationController slidingPanelController;

  const SignIn(this.slidingPanelController);
}

class SignUp extends SplashEvent {
  final AnimationController slidingPanelController;

  const SignUp(this.slidingPanelController);
}
