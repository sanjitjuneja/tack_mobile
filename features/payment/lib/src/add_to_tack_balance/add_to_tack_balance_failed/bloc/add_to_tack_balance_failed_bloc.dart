import 'package:core/core.dart';
import 'package:navigation/navigation.dart';

part 'add_to_tack_balance_failed_event.dart';
part 'add_to_tack_balance_failed_state.dart';

class AddToTackBalanceFailedBloc
    extends Bloc<AddToTackBalanceFailedEvent, AddToTackBalanceFailedState> {
  final AppRouterDelegate _appRouter;

  AddToTackBalanceFailedBloc({
    required AppRouterDelegate appRouter,
  })  : _appRouter = appRouter,
        super(const AddToTackBalanceFailedState()) {
    on<CloseRequest>(_onCloseRequest);
  }

  Future<void> _onCloseRequest(
      CloseRequest event,
      Emitter<AddToTackBalanceFailedState> emit,
      ) async {
    _appRouter.pop();
  }
}
