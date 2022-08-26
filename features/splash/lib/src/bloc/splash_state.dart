part of 'splash_bloc.dart';

class SplashState {
  final AnimationController? slidingPanelController;

  const SplashState({
    this.slidingPanelController,
  });

  SplashState copyWith({
    AnimationController? slidingPanelController,
  }) {
    return SplashState(
      slidingPanelController:
          slidingPanelController ?? this.slidingPanelController,
    );
  }
}
