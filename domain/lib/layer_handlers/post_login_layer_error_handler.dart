import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:domain/use_case.dart';
import 'package:navigation/navigation.dart';

class PostLoginLayerErrorHandler extends LayerErrorHandler {
  final GlobalAppRouterDelegate _globalAppRouter;
  final LogOutUseCase _logOutUseCase;

  const PostLoginLayerErrorHandler({
    required GlobalAppRouterDelegate globalAppRouter,
    required LogOutUseCase logOutUseCase,
  })  : _globalAppRouter = globalAppRouter,
        _logOutUseCase = logOutUseCase;

  @override
  Never proceedError(AppException exception) {
    if (exception is UnauthorizedException) {
      _logOutUseCase.execute(NoParams());
      ToastManager.showToast(
        _globalAppRouter.navigatorKey.currentContext!,
        messageKey: 'toast.sessionExpired',
        gravity: ToastGravity.BOTTOM,
      );
    }

    throw exception;
  }
}
