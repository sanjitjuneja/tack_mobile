import 'package:core/core.dart';
import 'package:navigation/navigation.dart';

part 'withdraw_successful_event.dart';
part 'withdraw_successful_state.dart';

class WithdrawSuccessfulBloc
    extends Bloc<WithdrawSuccessfulEvent, WithdrawSuccessfulState> {
  final AppRouterDelegate _appRouter;

  WithdrawSuccessfulBloc({
    required AppRouterDelegate appRouter,
  })  : _appRouter = appRouter,
        super(const WithdrawSuccessfulState()) {
    on<CloseRequest>(_onCloseRequest);
  }

  Future<void> _onCloseRequest(
    CloseRequest event,
    Emitter<WithdrawSuccessfulState> emit,
  ) async {
    _appRouter.pop();
  }
}
