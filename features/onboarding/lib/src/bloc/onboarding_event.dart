part of 'onboarding_bloc.dart';

abstract class OnboardingEvent {
  const OnboardingEvent();
}

class RequestNotificationsPermissions extends OnboardingEvent {
  const RequestNotificationsPermissions();
}

class SignUpAction extends OnboardingEvent {
  const SignUpAction();
}

class SignInAction extends OnboardingEvent {
  const SignInAction();
}
