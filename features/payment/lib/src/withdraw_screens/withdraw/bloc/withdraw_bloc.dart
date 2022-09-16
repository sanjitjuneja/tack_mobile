import 'dart:async';
import 'dart:math';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:domain/use_case.dart';
import 'package:navigation/navigation.dart';

import '../../withdraw_failed/ui/withdraw_failed_page.dart';
import '../../withdraw_successful/ui/withdraw_successful_page.dart';
import '../../select_withdraw_payment_method/ui/select_withdraw_payment_method_page.dart';

part 'withdraw_event.dart';

part 'withdraw_state.dart';

class WithdrawBloc extends Bloc<WithdrawEvent, WithdrawState> {
  final AppRouterDelegate _appRouter;
  final FetchConnectedBankAccountsUseCase _fetchConnectedBankAccountsUseCase;
  final ObserveUserBalanceUseCase _observeUserBalanceUseCase;
  final FetchUserBalanceUseCase _fetchUserBalanceUseCase;
  final FetchFeeUseCase _fetchFeeUseCase;
  final HandleDwollaWithdrawUseCase _handleDwollaWithdrawUseCase;

  late StreamSubscription<UserBankAccount> _userBalanceSubscription;

  WithdrawBloc({
    required AppRouterDelegate appRouter,
    required FetchConnectedBankAccountsUseCase
        fetchConnectedBankAccountsUseCase,
    required ObserveUserBalanceUseCase observeUserBalanceUseCase,
    required FetchUserBalanceUseCase fetchUserBalanceUseCase,
    required GetUserBalanceUseCase getUserBalanceUseCase,
    required HandleDwollaWithdrawUseCase handleDwollaWithdrawUseCase,
    required FetchFeeUseCase fetchFeeUseCase,
  })  : _appRouter = appRouter,
        _fetchConnectedBankAccountsUseCase = fetchConnectedBankAccountsUseCase,
        _observeUserBalanceUseCase = observeUserBalanceUseCase,
        _fetchUserBalanceUseCase = fetchUserBalanceUseCase,
        _fetchFeeUseCase = fetchFeeUseCase,
        _handleDwollaWithdrawUseCase = handleDwollaWithdrawUseCase,
        super(
          WithdrawState(
            withdrawAmount: 0.0,
            userBalance: getUserBalanceUseCase.execute(NoParams()),
            bankAccounts: [],
            selectedBankAccount: null,
            fee: null,
          ),
        ) {
    on<InitialLoad>(_onInitialLoad);

    on<UpdateWithdrawAmountAction>(_onUpdateWithdrawAmountAction);
    on<SelectBankAccountAction>(_onSelectBankAccountAction);
    on<UserBalanceUpdate>(_onUserBalanceUpdate);
    on<MakeWithdrawRequest>(_onMakeWithdrawRequest);

    _userBalanceSubscription =
        _observeUserBalanceUseCase.execute(NoParams()).listen(
      (UserBankAccount newUserBalance) {
        final UserBalanceUpdate event = UserBalanceUpdate(
          userBalance: newUserBalance,
        );
        add(event);
      },
    );

    add(const InitialLoad());
  }

  Future<void> _onInitialLoad(
    InitialLoad event,
    Emitter<WithdrawState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      final List<ConnectedBankAccount> bankAccounts =
          await _fetchConnectedBankAccountsUseCase.execute(
        const FetchConnectedBankAccountsPayload(),
      );

      await _fetchUserBalanceUseCase.execute(const FetchUserBalancePayload());

      final Fee fee = await _fetchFeeUseCase.execute(
        const FetchFeePayload(),
      );

      emit(
        state.copyWith(
          selectedBankAccount: _findPrimaryBankAccount(
            bankAccounts: bankAccounts,
          ),
          fee: fee,
          isLoading: false,
          hasError: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          hasError: true,
          isLoading: false,
        ),
      );
    }
  }

  Future<void> _onSelectBankAccountAction(
    SelectBankAccountAction event,
    Emitter<WithdrawState> emit,
  ) async {
    final ConnectedBankAccount? result = await _appRouter.pushForResult(
      SelectWithdrawPaymentMethodFeature.page(
        selectedBankAccount: state.selectedBankAccount,
      ),
    );
    emit(state.copyWith(selectedBankAccount: result));
  }

  ConnectedBankAccount? _findPrimaryBankAccount({
    required List<ConnectedBankAccount> bankAccounts,
  }) {
    for (final bankAccount in bankAccounts) {
      if (bankAccount.isPrimary) {
        return bankAccount;
      }
    }

    return null;
  }

  Future<void> _onUpdateWithdrawAmountAction(
    UpdateWithdrawAmountAction event,
    Emitter<WithdrawState> emit,
  ) async {
    emit(
      state.copyWith(
        withdrawAmount: event.withdrawAmount,
      ),
    );
  }

  Future<void> _onMakeWithdrawRequest(
    MakeWithdrawRequest event,
    Emitter<WithdrawState> emit,
  ) async {
    try {
      _appRouter.push(ProgressDialog.page());
      await _handleDwollaWithdrawUseCase.execute(
        HandleDwollaWithdrawPayload(
          paymentMethodId: state.selectedBankAccount!.id,
          amountInCents: state.withdrawAmount.toCentsFormat,
          currency: Constants.usd,
        ),
      );
      _appRouter.pop();
      _appRouter.replace(
        WithdrawSuccessfulFeature.page(),
      );
    } on TransactionsLimitException {
      _appRouter.pop();
      _appRouter.push(
        WithdrawFailedFeature.page(
          errorKey: 'withdrawFailedScreen.limitReached',
        ),
      );
    } catch (e) {
      _appRouter.pop();
      _appRouter.push(
        WithdrawFailedFeature.page(
          errorKey: 'withdrawFailedScreen.unableToProcess',
        ),
      );
    }
  }

  Future<void> _onUserBalanceUpdate(
    UserBalanceUpdate event,
    Emitter<WithdrawState> emit,
  ) async {
    emit(
      state.copyWith(userBalance: event.userBalance),
    );
  }

  @override
  Future<void> close() {
    _userBalanceSubscription.cancel();

    return super.close();
  }
}
