import 'dart:async';

import 'package:core/core.dart';
import 'package:navigation/navigation.dart';
import 'package:payment/payment.dart';
import 'package:domain/payment/payment.dart';

part 'payment_settings_event.dart';

part 'payment_settings_state.dart';

class PaymentSettingsBloc
    extends Bloc<PaymentSettingsEvent, PaymentSettingsState> {
  final AppRouterDelegate _appRouter;
  final FetchConnectedBankAccountsUseCase _fetchConnectedBankAccountsUseCase;
  final FetchConnectedCardsUseCase _fetchConnectedCardsUseCase;
  final FetchIsApplePaySupportedUseCase _fetchIsApplePaySupportedUseCase;
  final FetchIsGooglePaySupportedUseCase _fetchIsGooglePaySupportedUseCase;

  PaymentSettingsBloc({
    required AppRouterDelegate appRouter,
    required FetchConnectedBankAccountsUseCase
        fetchConnectedBankAccountsUseCase,
    required FetchConnectedCardsUseCase fetchConnectedCardsUseCase,
    required FetchIsApplePaySupportedUseCase fetchIsApplePaySupportedUseCase,
    required FetchIsGooglePaySupportedUseCase fetchIsGooglePaySupportedUseCase,
  })  : _appRouter = appRouter,
        _fetchConnectedBankAccountsUseCase = fetchConnectedBankAccountsUseCase,
        _fetchConnectedCardsUseCase = fetchConnectedCardsUseCase,
        _fetchIsApplePaySupportedUseCase = fetchIsApplePaySupportedUseCase,
        _fetchIsGooglePaySupportedUseCase = fetchIsGooglePaySupportedUseCase,
        super(
          const PaymentSettingsState(
            bankAccounts: <ConnectedBankAccount>[],
            cards: <ConnectedCard>[],
          ),
        ) {
    on<InitialLoad>(_onInitialLoad);

    on<AddCashAction>(_onAddCashAction);
    on<PayoutAction>(_onPayloadAction);
    on<AddPaymentMethodAction>(_onAddPaymentMethodAction);
    on<PaymentMethodDetailsAction>(_onPaymentMethodDetailsAction);

    add(const InitialLoad());
  }

  Future<void> _onInitialLoad(
    InitialLoad event,
    Emitter<PaymentSettingsState> emit,
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

      emit(
        state.copyWith(
          bankAccounts: bankAccounts,
          cards: cards,
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

  Future<void> _onPayloadAction(
    PayoutAction event,
    Emitter<PaymentSettingsState> emit,
  ) async {
    _appRouter.push(WithdrawFeature.page());
  }

  Future<void> _onAddCashAction(
    AddCashAction event,
    Emitter<PaymentSettingsState> emit,
  ) async {
    _appRouter.push(AddToTackBalanceFeature.page());
  }

  Future<void> _onAddPaymentMethodAction(
    AddPaymentMethodAction event,
    Emitter<PaymentSettingsState> emit,
  ) async {
    _appRouter.push(AddPaymentMethodFeature.page());
  }

  Future<void> _onPaymentMethodDetailsAction(
    PaymentMethodDetailsAction event,
    Emitter<PaymentSettingsState> emit,
  ) async {
    if (event.card != null) {
      _appRouter.push(
        PaymentMethodDetailsFeature.cardDetailsPage(
          card: event.card!,
        ),
      );
    } else {
      _appRouter.push(
        PaymentMethodDetailsFeature.bankDetailsPage(
          bankAccount: event.bankAccount!,
        ),
      );
    }
  }
}
