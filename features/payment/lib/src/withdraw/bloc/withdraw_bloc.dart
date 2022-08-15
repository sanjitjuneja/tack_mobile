import 'package:core/core.dart';
import 'package:navigation/navigation.dart';
import '../widgets/withdraw_method_type.dart';

part 'withdraw_event.dart';

part 'withdraw_state.dart';

class WithdrawBloc extends Bloc<WithdrawEvent, WithdrawState> {
  final AppRouterDelegate _appRouter;

  WithdrawBloc({
    required AppRouterDelegate appRouter,
  })  : _appRouter = appRouter,
        super(
          const WithdrawState(
            withdrawMethodType: WithdrawMethodType.instant,
          ),
        ) {
    on<ChangeWithdrawMethodTypeRequest>(_onChangeWithdrawMethodTypeRequest);
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
}
