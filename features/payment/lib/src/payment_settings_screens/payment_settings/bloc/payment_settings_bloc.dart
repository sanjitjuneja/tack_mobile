import 'dart:async';

import 'package:core/core.dart';
import 'package:navigation/navigation.dart';
import 'package:payment/payment.dart';
import '../../add_payment_method_screens/add_payment_method/ui/add_payment_method_page.dart';
import 'package:domain/payment/payment.dart';

part 'payment_settings_event.dart';

part 'payment_settings_state.dart';

class PaymentSettingsBloc
    extends Bloc<PaymentSettingsEvent, PaymentSettingsState> {
  final AppRouterDelegate _appRouter;
  final GetConnectedBankAccountsUseCase _getConnectedBankAccountsUseCase;
  final GetConnectedCardsUseCase _getConnectedCardsUseCase;

  PaymentSettingsBloc({
    required AppRouterDelegate appRouter,
    required GetConnectedBankAccountsUseCase getConnectedBankAccountsUseCase,
    required GetConnectedCardsUseCase getConnectedCardsUseCase,
  })  : _appRouter = appRouter,
        _getConnectedBankAccountsUseCase = getConnectedBankAccountsUseCase,
        _getConnectedCardsUseCase = getConnectedCardsUseCase,
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

    add(const InitialLoad());
  }

  Future<void> _onInitialLoad(
    InitialLoad event,
    Emitter<PaymentSettingsState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      final List<ConnectedBankAccount> bankAccounts =
          await _getConnectedBankAccountsUseCase.execute(
        const GetConnectedBankAccountsPayload(),
      );
      final List<ConnectedCard> cards = await _getConnectedCardsUseCase.execute(
        const GetConnectedCardsPayload(),
      );
      final bool isGooglePaySupported =
          await Stripe.instance.isGooglePaySupported(
        const IsGooglePaySupportedParams(),
      );
      final bool isApplePaySupported =
          Stripe.instance.isApplePaySupported.value;

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
}
