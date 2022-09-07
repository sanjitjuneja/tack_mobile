part of 'splash_bloc.dart';

abstract class SplashEvent {
  const SplashEvent();
}

class InitialEvent extends SplashEvent {
  const InitialEvent();
}
