part of 'deeplink_bloc.dart';

abstract class DeeplinkEvent {
  const DeeplinkEvent();
}

class InitialCheck extends DeeplinkEvent {
  const InitialCheck();
}

class ResetLastDeeplinkAction extends DeeplinkEvent {
  const ResetLastDeeplinkAction();
}

class DeeplinkAction extends DeeplinkEvent {
  final DeeplinkIntent intent;

  const DeeplinkAction({
    required this.intent,
  });
}
