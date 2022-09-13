import 'dart:async';
import 'package:core/core.dart';
import 'package:navigation/navigation.dart';
import 'package:domain/domain.dart';

import '../../../../payment.dart';
import '../../models/deposit_selected_payment_method.dart';

part 'select_deposit_payment_method_event.dart';

part 'select_deposit_payment_method_state.dart';

class SelectDepositPaymentMethodBloc
    extends Bloc<SelectDepositPaymentMethodEvent, SelectDepositPaymentMethodState> {
  final AppRouterDelegate _appRouter;
  final FetchConnectedBankAccountsUseCase _fetchConnectedBankAccountsUseCase;
  final FetchConnectedCardsUseCase _fetchConnectedCardsUseCase;
  final FetchIsApplePaySupportedUseCase _fetchIsApplePaySupportedUseCase;
  final FetchIsGooglePaySupportedUseCase _fetchIsGooglePaySupportedUseCase;
  final FetchFeeUseCase _feeUseCase;

  SelectDepositPaymentMethodBloc({
    required AppRouterDelegate appRouter,
    required FetchConnectedBankAccountsUseCase
        fetchConnectedBankAccountsUseCase,
    required FetchConnectedCardsUseCase fetchConnectedCardsUseCase,
    required FetchIsApplePaySupportedUseCase fetchIsApplePaySupportedUseCase,
    required FetchIsGooglePaySupportedUseCase fetchIsGooglePaySupportedUseCase,
    required FetchFeeUseCase feeUseCase,
    required String? selectedPaymentMethodId,
  })  : _appRouter = appRouter,
        _fetchConnectedBankAccountsUseCase = fetchConnectedBankAccountsUseCase,
        _fetchConnectedCardsUseCase = fetchConnectedCardsUseCase,
        _fetchIsApplePaySupportedUseCase = fetchIsApplePaySupportedUseCase,
        _fetchIsGooglePaySupportedUseCase = fetchIsGooglePaySupportedUseCase,
        _feeUseCase = feeUseCase,
        super(
          SelectDepositPaymentMethodState(
            bankAccounts: <ConnectedBankAccount>[],
            cards: <ConnectedCard>[],
            selectedPaymentMethodId: selectedPaymentMethodId,
            fee: null,
          ),
        ) {
    on<InitialLoad>(_onInitialLoad);

    on<SelectDepositPaymentMethodAction>(_onSelectDepositPaymentMethodAction);
    on<AddPaymentMethodAction>(_onAddPaymentMethodAction);

    add(const InitialLoad());
  }

  Future<void> _onInitialLoad(
    InitialLoad event,
    Emitter<SelectDepositPaymentMethodState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      final List<ConnectedBankAccount> bankAccounts =
          await _fetchConnectedBankAccountsUseCase.execute(
        const FetchConnectedBankAccountsPayload(),
      );
      final List<ConnectedCard> cards =
          await _fetchConnectedCardsUseCase.execute(
        const FetchConnectedCardsPayload(),
      );
      final bool isApplePaySupported =
          await _fetchIsApplePaySupportedUseCase.execute(
        const FetchIsApplePaySupportedPayload(),
      );
      final bool isGooglePaySupported =
          await _fetchIsGooglePaySupportedUseCase.execute(
        const FetchIsGooglePaySupportedPayload(),
      );

      final Fee fee = await _feeUseCase.execute(
        const FetchFeePayload(),
      );

      emit(
        state.copyWith(
          bankAccounts: bankAccounts,
          cards: cards,
          fee: fee,
          isApplePaySupported: isApplePaySupported,
          isGooglePaySupported: isGooglePaySupported,
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

  Future<void> _onSelectDepositPaymentMethodAction(
    SelectDepositPaymentMethodAction event,
    Emitter<SelectDepositPaymentMethodState> emit,
  ) async {
    emit(state.copyWith(selectedPaymentMethodId: event.paymentMethodId));
  }

  Future<void> _onAddPaymentMethodAction(
    AddPaymentMethodAction event,
    Emitter<SelectDepositPaymentMethodState> emit,
  ) async {
    final AddPaymentMethodScreenResult? result = await _appRouter.pushForResult(
      AddPaymentMethodFeature.page(
        bankAccountsAmount: state.bankAccounts.length,
      ),
    );
    if (result != null) {
      add(const InitialLoad());
    }
  }
}
