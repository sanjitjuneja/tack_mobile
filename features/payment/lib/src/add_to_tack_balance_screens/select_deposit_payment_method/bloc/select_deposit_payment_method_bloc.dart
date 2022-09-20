import 'dart:async';

import 'package:core/core.dart';
import 'package:navigation/navigation.dart';
import 'package:domain/domain.dart';

import '../../../payment_settings_screens/add_credit_card/ui/add_credit_card_page.dart';
import '../../../payment_settings_screens/add_payment_method_screens/add_payment_method_failed/ui/add_payment_method_failed_page.dart';
import '../../models/deposit_selected_payment_method.dart';

part 'select_deposit_payment_method_event.dart';

part 'select_deposit_payment_method_state.dart';

class SelectDepositPaymentMethodBloc extends Bloc<
    SelectDepositPaymentMethodEvent, SelectDepositPaymentMethodState> {
  final AppRouterDelegate _appRouter;
  final FetchConnectedBankAccountsUseCase _fetchConnectedBankAccountsUseCase;
  final FetchConnectedCardsUseCase _fetchConnectedCardsUseCase;
  final FetchIsApplePaySupportedUseCase _fetchIsApplePaySupportedUseCase;
  final FetchIsGooglePaySupportedUseCase _fetchIsGooglePaySupportedUseCase;
  final FetchFeeUseCase _feeUseCase;
  final AddBankAccountUseCase _addBankAccountUseCase;

  SelectDepositPaymentMethodBloc({
    required AppRouterDelegate appRouter,
    required FetchConnectedBankAccountsUseCase
        fetchConnectedBankAccountsUseCase,
    required FetchConnectedCardsUseCase fetchConnectedCardsUseCase,
    required FetchIsApplePaySupportedUseCase fetchIsApplePaySupportedUseCase,
    required FetchIsGooglePaySupportedUseCase fetchIsGooglePaySupportedUseCase,
    required FetchFeeUseCase feeUseCase,
    required String? selectedPaymentMethodId,
    required AddBankAccountUseCase addBankAccountUseCase,
  })  : _appRouter = appRouter,
        _fetchConnectedBankAccountsUseCase = fetchConnectedBankAccountsUseCase,
        _fetchConnectedCardsUseCase = fetchConnectedCardsUseCase,
        _fetchIsApplePaySupportedUseCase = fetchIsApplePaySupportedUseCase,
        _fetchIsGooglePaySupportedUseCase = fetchIsGooglePaySupportedUseCase,
        _feeUseCase = feeUseCase,
        _addBankAccountUseCase = addBankAccountUseCase,
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
    on<AddBankAction>(_onAddBankAction);
    on<AddCardAction>(_onAddCardAction);
    on<ContinueAction>(_onContinueAction);

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

  Future<void> _onAddBankAction(
    AddBankAction event,
    Emitter<SelectDepositPaymentMethodState> emit,
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
        _appRouter.pushProgress();
        final List<ConnectedBankAccount>? bankAccounts =
            await _addBankAccountUseCase.execute(
          const AddBankAccountPayload(),
        );
        _appRouter.popProgress();
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
      _appRouter.popProgress();
      _appRouter.push(
        AddPaymentMethodFailedFeature.page(
          titleKey: 'addPaymentMethodFailedScreen.unableToAdd',
          descriptionKey: 'addPaymentMethodFailedScreen.description',
        ),
      );
    }
  }

  Future<void> _onAddCardAction(
    AddCardAction event,
    Emitter<SelectDepositPaymentMethodState> emit,
  ) async {
    final bool? result = await _appRouter.pushForResult(
      AddCreditCardFeature.page(),
    );
    if (result == true) {
      add(const InitialLoad());
    }
  }

  Future<void> _onContinueAction(
    ContinueAction event,
    Emitter<SelectDepositPaymentMethodState> emit,
  ) async {
    _appRouter.popWithResult(
      state.selectedPaymentMethod,
    );
  }
}
