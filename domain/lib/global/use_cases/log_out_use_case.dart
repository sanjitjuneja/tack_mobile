part of global;

class LogOutUseCase extends FutureUseCase<void, NoParams> {
  final GlobalAppRouterDelegate _globalAppRouter;
  final AuthRepository _authRepository;

  LogOutUseCase({
    required GlobalAppRouterDelegate globalAppRouter,
    required AuthRepository authRepository,
  })  : _globalAppRouter = globalAppRouter,
        _authRepository = authRepository;

  @override
  Future<void> execute(NoParams params) async {
    await dataDI.unregisterPostLoginAppLocator();
    await _authRepository.logout();
    _globalAppRouter.replace(OnboardingFeature.page());
  }
}
