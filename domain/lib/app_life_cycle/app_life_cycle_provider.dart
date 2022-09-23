part of app_life_cycle;

class AppLifeCycleProvider with WidgetsBindingObserver {
  static const Duration _autoSleepDuration = Duration(seconds: 120);

  final GlobalAppRouterDelegate _globalAppRouter;

  final List<AppLifeCycleObserver> _observers = <AppLifeCycleObserver>[];

  late StreamSubscription<ConnectivityResult> _internetConnectionSubscription;

  Timer? _autoSleepTimer;
  bool _isOnline = true;

  AppLifeCycleProvider({
    required GlobalAppRouterDelegate globalAppRouter,
  }) : _globalAppRouter = globalAppRouter {
    WidgetsBinding.instance.addObserver(this);
    _internetConnectionSubscription = InternetConnectionService
        .onConnectivityChanged
        .listen(_onInternetConnectionChanged);
  }

  void checkConnection() async {
    _checkConnectivity();
  }

  Future<void> _checkConnectivity() async {
    final bool isConnected = await InternetConnectionService.isConnected;

    if (!isConnected) _handleOffline();
  }

  void addObserver(AppLifeCycleObserver observer) {
    return _observers.add(observer);
  }

  bool removeObserver(AppLifeCycleObserver observer) {
    return _observers.remove(observer);
  }

  void _handleShouldRefresh() {
    for (final AppLifeCycleObserver observer in _observers) {
      observer.onShouldRefresh();
    }
  }

  void _handleShouldSleep() {
    for (final AppLifeCycleObserver observer in _observers) {
      observer.onShouldSleep();
    }
  }

  void _handleShouldDispose() {
    for (final AppLifeCycleObserver observer in _observers) {
      observer.onShouldDispose();
    }
  }

  void _handleOffline() {
    _removeAutoSleep();
    _handleShouldSleep();
    _globalAppRouter.push(OfflineFeature.page());
  }

  void _handleOnline() {
    _handleShouldRefresh();
    _globalAppRouter.removeNamed(OfflineFeature.routeName);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      _removeAutoSleep();
      _handleShouldDispose();
    } else if (state == AppLifecycleState.resumed) {
      if (_autoSleepTimer != null && !_autoSleepTimer!.isActive) {
        _handleShouldRefresh();
      }
      _removeAutoSleep();
    } else if (state == AppLifecycleState.paused) {
      _autoSleepTimer = Timer(
        _autoSleepDuration,
        _handleShouldSleep,
      );
    }

    super.didChangeAppLifecycleState(state);
  }

  void _onInternetConnectionChanged(ConnectivityResult connectivity) {
    if (connectivity == ConnectivityResult.none) {
      if (_isOnline) {
        _handleOffline();
        _isOnline = false;
      }
    } else {
      if (!_isOnline) {
        _handleOnline();
        _isOnline = true;
      }
    }
  }

  void _removeAutoSleep() {
    _autoSleepTimer?.cancel();
    _autoSleepTimer = null;
  }

  void dispose() {
    _internetConnectionSubscription.cancel();

    WidgetsBinding.instance.removeObserver(this);
  }
}
