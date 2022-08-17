import 'package:core/core.dart';
import 'package:navigation/navigation.dart';
import 'package:payment/src/withdraw/withdraw_successful/ui/withdraw_successful_page.dart';
import '../widgets/withdraw_method_type.dart';

part 'withdraw_amount_event.dart';

part 'withdraw_amount_state.dart';

class WithdrawAmountBloc
    extends Bloc<WithdrawAmountEvent, WithdrawAmountState> {
  final AppRouterDelegate _appRouter;

  WithdrawAmountBloc({
    required AppRouterDelegate appRouter,
  })  : _appRouter = appRouter,
        super(
          const WithdrawAmountState(
            withdrawMethodType: WithdrawMethodType.instant,
          ),
        ) {
    on<ChangeWithdrawAmountMethodTypeRequest>(
        _onChangeWithdrawAmountMethodTypeRequest);
    on<MakeWithdrawAmountRequest>(_onMakeWithdrawAmountRequest);
  }

  Future<void> _onChangeWithdrawAmountMethodTypeRequest(
    ChangeWithdrawAmountMethodTypeRequest event,
    Emitter<WithdrawAmountState> emit,
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

  Future<void> _onMakeWithdrawAmountRequest(
    MakeWithdrawAmountRequest event,
    Emitter<WithdrawAmountState> emit,
  ) async {
    _appRouter.replace(
      WithdrawSuccessfulFeature.page(
        withdrawMethodType: state.withdrawMethodType,
      ),
    );
  }
}
