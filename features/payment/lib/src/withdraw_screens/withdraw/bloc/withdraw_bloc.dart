import 'package:core/core.dart';
import 'package:navigation/navigation.dart';
import 'package:payment/src/withdraw_screens/withdraw_successful/ui/withdraw_successful_page.dart';
import '../widgets/withdraw_method_type.dart';

part 'withdraw_event.dart';

part 'withdraw_state.dart';

class WithdrawBloc
    extends Bloc<WithdrawEvent, WithdrawState> {
  final AppRouterDelegate _appRouter;

  WithdrawBloc({
    required AppRouterDelegate appRouter,
  })  : _appRouter = appRouter,
        super(
          const WithdrawState(
            withdrawMethodType: WithdrawMethodType.instant,
          ),
        ) {
    on<ChangeWithdrawMethodTypeRequest>(
        _onChangeWithdrawMethodTypeRequest);
    on<MakeWithdrawRequest>(_onMakeWithdrawRequest);
  }

  Future<void> _onChangeWithdrawMethodTypeRequest(
    ChangeWithdrawMethodTypeRequest event,
    Emitter<WithdrawState> emit,
  ) async {
    emit(
      state.copyWith(
        withdrawMethodType:
            state.withdrawMethodType == WithdrawMethodType.instant
                ? WithdrawMethodType.regular
                : WithdrawMethodType.instant,
      ),
    );
  }

  Future<void> _onMakeWithdrawRequest(
    MakeWithdrawRequest event,
    Emitter<WithdrawState> emit,
  ) async {
    _appRouter.replace(
      WithdrawSuccessfulFeature.page(
        withdrawMethodType: state.withdrawMethodType,
      ),
    );
  }
}
