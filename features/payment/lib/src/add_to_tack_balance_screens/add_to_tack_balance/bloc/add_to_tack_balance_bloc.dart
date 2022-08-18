import 'package:core/core.dart';
import 'package:navigation/navigation.dart';
import '../../add_to_tack_balance_failed/ui/add_to_tack_balance_failed_page.dart';
import '../../add_to_tack_balance_successful/ui/add_to_tack_balance_successful_page.dart';

part 'add_to_tack_balance_event.dart';

part 'add_to_tack_balance_state.dart';

class AddToTackBalanceBloc
    extends Bloc<AddToTackBalanceEvent, AddToTackBalanceState> {
  final AppRouterDelegate _appRouter;

  AddToTackBalanceBloc({
    required AppRouterDelegate appRouter,
  })  : _appRouter = appRouter,
        super(const AddToTackBalanceState()) {
    on<MakeAddToTackBalanceRequest>(_onMakeAddToTackBalanceRequest);
  }

  Future<void> _onMakeAddToTackBalanceRequest(
    MakeAddToTackBalanceRequest event,
    Emitter<AddToTackBalanceState> emit,
  ) async {
    _appRouter.replace(AddToTackBalanceSuccessfulFeature.page());
  }
}
