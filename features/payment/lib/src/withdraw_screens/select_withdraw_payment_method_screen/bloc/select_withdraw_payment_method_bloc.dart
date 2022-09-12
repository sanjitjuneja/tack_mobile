import 'dart:async';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:navigation/navigation.dart';
import 'package:domain/domain.dart';

import '../../../payment_settings_screens/add_payment_method_screens/add_payment_method_failed/ui/add_payment_method_failed_page.dart';

part 'select_withdraw_payment_method_event.dart';

part 'select_withdraw_payment_method_state.dart';

class SelectWithdrawPaymentMethodBloc extends Bloc<
    SelectWithdrawPaymentMethodEvent, SelectWithdrawPaymentMethodState> {
  final AppRouterDelegate _appRouter;
  final FetchConnectedBankAccountsUseCase _fetchConnectedBankAccountsUseCase;
  final FetchFeeUseCase _feeUseCase;
  final AddBankAccountUseCase _addBankAccountUseCase;

  SelectWithdrawPaymentMethodBloc({
    required AppRouterDelegate appRouter,
    required FetchConnectedBankAccountsUseCase
        fetchConnectedBankAccountsUseCase,
    required FetchFeeUseCase feeUseCase,
    required ConnectedBankAccount? selectedBankAccount,
    required AddBankAccountUseCase addBankAccountUseCase,
  })  : _appRouter = appRouter,
        _fetchConnectedBankAccountsUseCase = fetchConnectedBankAccountsUseCase,
        _feeUseCase = feeUseCase,
        _addBankAccountUseCase = addBankAccountUseCase,
        super(
          SelectWithdrawPaymentMethodState(
            bankAccounts: <ConnectedBankAccount>[],
            selectedBankAccount: selectedBankAccount,
            fee: null,
          ),
        ) {
    on<InitialLoad>(_onInitialLoad);

    on<SelectWithdrawPaymentMethodAction>(_onSelectWithdrawPaymentMethodAction);
    on<AddBankAccountAction>(_onAddBankAccountAction);

    add(const InitialLoad());
  }

  Future<void> _onInitialLoad(
    InitialLoad event,
    Emitter<SelectWithdrawPaymentMethodState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      final List<ConnectedBankAccount> bankAccounts =
          await _fetchConnectedBankAccountsUseCase.execute(
        const FetchConnectedBankAccountsPayload(),
      );

      final Fee fee = await _feeUseCase.execute(
        const FetchFeePayload(),
      );

      emit(
        state.copyWith(
          bankAccounts: bankAccounts,
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

  Future<void> _onSelectWithdrawPaymentMethodAction(
    SelectWithdrawPaymentMethodAction event,
    Emitter<SelectWithdrawPaymentMethodState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedBankAccount: event.bankAccount,
      ),
    );
  }

  Future<void> _onAddBankAccountAction(
    AddBankAccountAction event,
    Emitter<SelectWithdrawPaymentMethodState> emit,
  ) async {
    try {
      if (state.bankAccounts.length >= Constants.maxBankAccountsAmount) {
        _appRouter.push(
          AddPaymentMethodFailedFeature.page(
            titleKey: 'addPaymentMethodFailedScreen.limitReached',
            descriptionKey: 'addPaymentMethodFailedScreen.limitDescription',
          ),
        );
      } else {
        _appRouter.push(ProgressDialog.page());
        final List<ConnectedBankAccount>? bankAccounts =
            await _addBankAccountUseCase.execute(
          const AddBankAccountPayload(),
        );
        _appRouter.pop();
        if (bankAccounts != null) {
          if (bankAccounts.isEmpty) {
            _appRouter.push(
              AddPaymentMethodFailedFeature.page(
                titleKey: 'addPaymentMethodFailedScreen.unableToAdd',
                descriptionKey:
                    'addPaymentMethodFailedScreen.depositoryDescription',
              ),
            );
          } else {
            add(const InitialLoad());
          }
        }
      }
    } catch (e) {
      _appRouter.pop();
      _appRouter.push(
        AddPaymentMethodFailedFeature.page(
          titleKey: 'addPaymentMethodFailedScreen.unableToAdd',
          descriptionKey: 'addPaymentMethodFailedScreen.description',
        ),
      );
    }
  }
}
