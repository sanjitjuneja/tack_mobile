import 'package:core/core.dart';
import 'package:navigation/navigation.dart';
import '../../add_to_tack_balance_failed/ui/add_to_tack_balance_failed_page.dart';
import '../../add_to_tack_balance_successful/ui/add_to_tack_balance_successful_page.dart';

part 'add_to_tack_balance_amount_event.dart';

part 'add_to_tack_balance_amount_state.dart';

class AddToTackBalanceAmountBloc
    extends Bloc<AddToTackBalanceAmountEvent, AddToTackBalanceAmountState> {
  final AppRouterDelegate _appRouter;

  AddToTackBalanceAmountBloc({
    required AppRouterDelegate appRouter,
  })  : _appRouter = appRouter,
        super(const AddToTackBalanceAmountState()) {
    on<MakeAddToTackBalanceRequest>(_onMakeAddToTackBalanceRequest);
  }

  Future<void> _onMakeAddToTackBalanceRequest(
    MakeAddToTackBalanceRequest event,
    Emitter<AddToTackBalanceAmountState> emit,
  ) async {
    _appRouter.replace(AddToTackBalanceFailedFeature.page());
  }
}
