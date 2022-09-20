import 'dart:async';

import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:domain/use_case.dart';
import 'package:flutter/services.dart';
import 'package:navigation/navigation.dart';

import '../../add_to_tack_balance_failed/ui/add_to_tack_balance_failed_page.dart';
import '../../select_deposit_payment_method/ui/select_deposit_payment_method_page.dart';
import '../../add_to_tack_balance_successful/ui/add_to_tack_balance_successful_page.dart';
import '../../models/deposit_selected_payment_method.dart';

part 'add_to_tack_balance_event.dart';

part 'add_to_tack_balance_state.dart';

class AddToTackBalanceBloc
    extends Bloc<AddToTackBalanceEvent, AddToTackBalanceState> {
  final AppRouterDelegate _appRouter;
  final FetchConnectedBankAccountsUseCase _fetchConnectedBankAccountsUseCase;
  final FetchConnectedCardsUseCase _fetchConnectedCardsUseCase;
  final ObserveUserBalanceUseCase _observeUserBalanceUseCase;
  final FetchUserBalanceUseCase _fetchUserBalanceUseCase;
  final FetchIsApplePaySupportedUseCase _fetchIsApplePaySupportedUseCase;
  final FetchIsGooglePaySupportedUseCase _fetchIsGooglePaySupportedUseCase;
  final HandleDwollaDepositUseCase _handleDwollaDepositUseCase;
  final HandleStripeDepositUseCase _handleStripeDepositUseCase;
  final FetchFeeUseCase _fetchFeeUseCase;

  late StreamSubscription<UserBankAccount> _userBalanceSubscription;

  AddToTackBalanceBloc({
    required AppRouterDelegate appRouter,
    required FetchConnectedBankAccountsUseCase
        fetchConnectedBankAccountsUseCase,
    required FetchConnectedCardsUseCase fetchConnectedCardsUseCase,
    required ObserveUserBalanceUseCase observeUserBalanceUseCase,
    required FetchUserBalanceUseCase fetchUserBalanceUseCase,
    required GetUserBalanceUseCase getUserBalanceUseCase,
    required FetchIsApplePaySupportedUseCase fetchIsApplePaySupportedUseCase,
    required FetchIsGooglePaySupportedUseCase fetchIsGooglePaySupportedUseCase,
    required HandleDwollaDepositUseCase handleDwollaDepositUseCase,
    required HandleStripeDepositUseCase handleStripeDepositUseCase,
    required FetchFeeUseCase fetchFeeUseCase,
  })  : _appRouter = appRouter,
        _fetchConnectedBankAccountsUseCase = fetchConnectedBankAccountsUseCase,
        _fetchConnectedCardsUseCase = fetchConnectedCardsUseCase,
        _observeUserBalanceUseCase = observeUserBalanceUseCase,
        _fetchUserBalanceUseCase = fetchUserBalanceUseCase,
        _fetchIsApplePaySupportedUseCase = fetchIsApplePaySupportedUseCase,
        _fetchIsGooglePaySupportedUseCase = fetchIsGooglePaySupportedUseCase,
        _handleDwollaDepositUseCase = handleDwollaDepositUseCase,
        _handleStripeDepositUseCase = handleStripeDepositUseCase,
        _fetchFeeUseCase = fetchFeeUseCase,
        super(
          AddToTackBalanceState(
            amount: 0.0,
            userBalance: getUserBalanceUseCase.execute(NoParams()),
            fee: null,
            selectedPaymentMethod: const DepositSelectedPaymentMethod(
              bankAccount: null,
              card: null,
            ),
          ),
        ) {
    on<InitialLoad>(_onInitialLoad);

    on<UpdateDepositAmountAction>(_onUpdateDepositAmountAction);
    on<MakeAddToTackBalanceRequest>(_onMakeAddToTackBalanceRequest);
    on<SelectPaymentMethodAction>(_onSelectPaymentMethodAction);

    on<UserBalanceUpdate>(_onUserBalanceUpdate);

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
    Emitter<AddToTackBalanceState> emit,
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

      await _fetchUserBalanceUseCase.execute(const FetchUserBalancePayload());

      final Fee fee = await _fetchFeeUseCase.execute(
        const FetchFeePayload(),
      );

      emit(
        state.copyWith(
          selectedPaymentMethod: DepositSelectedPaymentMethod(
            bankAccount: _findPrimaryBankAccount(
              bankAccounts: bankAccounts,
            ),
            card: _findPrimaryCard(
              cards: cards,
            ),
            isApplePay: isApplePaySupported,
            isGooglePay: isGooglePaySupported,
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

  Future<void> _onSelectPaymentMethodAction(
    SelectPaymentMethodAction event,
    Emitter<AddToTackBalanceState> emit,
  ) async {
    final DepositSelectedPaymentMethod? result = await _appRouter.pushForResult(
      SelectDepositPaymentMethodFeature.page(
        selectedPaymentMethodId: state.selectedPaymentMethodId,
      ),
    );
    emit(state.copyWith(selectedPaymentMethod: result));
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

  ConnectedCard? _findPrimaryCard({
    required List<ConnectedCard> cards,
  }) {
    for (final card in cards) {
      if (card.isPrimary) {
        return card;
      }
    }

    return null;
  }

  Future<void> _onMakeAddToTackBalanceRequest(
    MakeAddToTackBalanceRequest event,
    Emitter<AddToTackBalanceState> emit,
  ) async {
    try {
      _appRouter.pushProgress();
      if (state.selectedPaymentMethod.card != null) {
        await _handleStripeDepositUseCase.execute(
          HandleStripeDepositPayload(
            paymentMethodId: state.selectedPaymentMethod.card!.id,
            amountInCents: state.amount.toCentsFormat,
            currency: Constants.usd,
          ),
        );
      } else if (state.selectedPaymentMethod.bankAccount != null) {
        await _handleDwollaDepositUseCase.execute(
          HandleDwollaDepositPayload(
            paymentMethodId: state.selectedPaymentMethod.bankAccount!.id,
            amountInCents: state.amount.toCentsFormat,
            currency: Constants.usd,
          ),
        );
      } else if (state.selectedPaymentMethod.isApplePay) {
        await _handleStripeDepositUseCase.execute(
          HandleStripeDepositPayload(
            paymentMethodId: Constants.applePayId,
            amountInCents: state.amountInDollarFormatWithFee.toCentsFormat,
            currency: Constants.usd,
          ),
        );
      } else {
        await _handleStripeDepositUseCase.execute(
          HandleStripeDepositPayload(
            paymentMethodId: Constants.googlePayId,
            amountInCents: state.amount.toCentsFormat,
            currency: Constants.usd,
          ),
        );
      }
      _appRouter.popProgress();
      _appRouter.replace(
        AddToTackBalanceSuccessfulFeature.page(),
      );
    } on TransactionsLimitException {
      _appRouter.popProgress();
      _appRouter.push(
        AddToTackBalanceFailedFeature.page(
          errorKey: 'addToTackBalanceFailedScreen.limitReached',
        ),
      );
    } on StripeException catch (e) {
      if (e.error.code == FailureCode.Canceled) {
        _appRouter.popProgress();
      }
    } on PlatformException catch (e) {
      if (e.code == FailureCode.Canceled.name) {
        _appRouter.popProgress();
      }
    } catch (e) {
      _appRouter.popProgress();
      _appRouter.push(
        AddToTackBalanceFailedFeature.page(
          errorKey: 'addToTackBalanceFailedScreen.unableToAdd',
        ),
      );
    }
  }

  Future<void> _onUpdateDepositAmountAction(
    UpdateDepositAmountAction event,
    Emitter<AddToTackBalanceState> emit,
  ) async {
    emit(
      state.copyWith(amount: event.amount),
    );
  }

  Future<void> _onUserBalanceUpdate(
    UserBalanceUpdate event,
    Emitter<AddToTackBalanceState> emit,
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
