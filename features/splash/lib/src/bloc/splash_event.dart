part of 'splash_bloc.dart';

abstract class SplashEvent {
  const SplashEvent();
}

class InitialEvent extends SplashEvent {
  final AnimationController slidingPanelController;

  const InitialEvent(this.slidingPanelController);
}

class SignIn extends SplashEvent {
  const SignIn();
}

class SignUp extends SplashEvent {
  const SignUp();
}
