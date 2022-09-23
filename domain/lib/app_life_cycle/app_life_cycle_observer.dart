part of app_life_cycle;

abstract class AppLifeCycleObserver {
  void onShouldRefresh() {}

  void onShouldSleep() {}

  void onShouldDispose() {}
}
