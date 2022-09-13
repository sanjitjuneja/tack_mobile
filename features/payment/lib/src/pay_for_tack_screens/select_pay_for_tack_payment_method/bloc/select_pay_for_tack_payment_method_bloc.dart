import 'dart:async';
import 'package:core/core.dart';
import 'package:navigation/navigation.dart';
import 'package:domain/domain.dart';

import '../../../../payment.dart';
import '../../models/pay_for_tack_selected_payment_method.dart';

part 'select_pay_for_tack_payment_method_event.dart';

part 'select_pay_for_tack_payment_method_state.dart';

class SelectPayForTackPaymentMethodBloc
    extends Bloc<SelectPayForTackPaymentMethodEvent, SelectPayForTackPaymentMethodState> {
  final AppRouterDelegate _appRouter;
  final FetchConnectedBankAccountsUseCase _fetchConnectedBankAccountsUseCase;
  final FetchConnectedCardsUseCase _fetchConnectedCardsUseCase;
  final FetchIsApplePaySupportedUseCase _fetchIsApplePaySupportedUseCase;
  final FetchIsGooglePaySupportedUseCase _fetchIsGooglePaySupportedUseCase;
  final FetchFeeUseCase _feeUseCase;

  SelectPayForTackPaymentMethodBloc({
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
        SelectPayForTackPaymentMethodState(
          bankAccounts: <ConnectedBankAccount>[],
          cards: <ConnectedCard>[],
          selectedPaymentMethodId: selectedPaymentMethodId,
          fee: null,
        ),
      ) {
    on<InitialLoad>(_onInitialLoad);

    on<SelectPayForTackPaymentMethodAction>(_onSelectPayForTackPaymentMethodAction);
    on<AddPaymentMethodAction>(_onAddPaymentMethodAction);

    add(const InitialLoad());
  }

  Future<void> _onInitialLoad(
      InitialLoad event,
      Emitter<SelectPayForTackPaymentMethodState> emit,
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

  Future<void> _onSelectPayForTackPaymentMethodAction(
      SelectPayForTackPaymentMethodAction event,
      Emitter<SelectPayForTackPaymentMethodState> emit,
      ) async {
    emit(state.copyWith(selectedPaymentMethodId: event.paymentMethodId));
  }

  Future<void> _onAddPaymentMethodAction(
      AddPaymentMethodAction event,
      Emitter<SelectPayForTackPaymentMethodState> emit,
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
