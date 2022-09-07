part of 'onboarding_bloc.dart';

abstract class OnboardingEvent {
  const OnboardingEvent();
}

class SignUpAction extends OnboardingEvent {
  const SignUpAction();
}

class SignInAction extends OnboardingEvent {
  const SignInAction();
}
