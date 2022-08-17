import 'package:core/core.dart';
import 'package:navigation/navigation.dart';

part 'withdraw_failed_event.dart';

part 'withdraw_failed_state.dart';

class WithdrawFailedBloc
    extends Bloc<WithdrawFailedEvent, WithdrawFailedState> {
  final AppRouterDelegate _appRouter;

  WithdrawFailedBloc({
    required AppRouterDelegate appRouter,
  })  : _appRouter = appRouter,
        super(const WithdrawFailedState()) {
    on<CloseRequest>(_onCloseRequest);
  }

  Future<void> _onCloseRequest(
    CloseRequest event,
    Emitter<WithdrawFailedState> emit,
  ) async {
    _appRouter.pop();
  }
}
