import 'package:core/core.dart';
import 'package:navigation/navigation.dart';

part 'add_to_tack_balance_successful_event.dart';

part 'add_to_tack_balance_successful_state.dart';

class AddToTackBalanceSuccessfulBloc extends Bloc<
    AddToTackBalanceSuccessfulEvent, AddToTackBalanceSuccessfulState> {
  final AppRouterDelegate _appRouter;

  AddToTackBalanceSuccessfulBloc({
    required AppRouterDelegate appRouter,
  })  : _appRouter = appRouter,
        super(const AddToTackBalanceSuccessfulState()) {
    on<CloseRequest>(_onCloseRequest);
  }

  Future<void> _onCloseRequest(
    CloseRequest event,
    Emitter<AddToTackBalanceSuccessfulState> emit,
  ) async {
    _appRouter.pop();
  }
}
