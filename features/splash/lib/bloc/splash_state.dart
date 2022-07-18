abstract class SplashState {}

class SplashContent extends SplashState {
  final bool? needToBackAnimation;

  SplashContent({
    this.needToBackAnimation,
  });
}
