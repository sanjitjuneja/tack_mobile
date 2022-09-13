import 'dart:async';

import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:domain/use_case.dart';
import 'package:navigation/navigation.dart';

import '../../models/pay_for_tack_selected_payment_method.dart';

part 'pay_for_tack_event.dart';

part 'pay_for_tack_state.dart';

class PayForTackBloc extends Bloc<PayForTackEvent, PayForTackState> {
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

  PayForTackBloc({
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
    required Offer offer,
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
          PayForTackState(
            userBalance: getUserBalanceUseCase.execute(NoParams()),
            offer: offer,
            fee: null,
            selectedPaymentMethod: const PayForTackSelectedPaymentMethod(
              bankAccount: null,
              card: null,
            ),
          ),
        ) {
    on<InitialLoad>(_onInitialLoad);

    on<MakePayForTackRequest>(_onMakePayForTackRequest);
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
    Emitter<PayForTackState> emit,
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
          selectedPaymentMethod: PayForTackSelectedPaymentMethod(
            bankAccount: _findPrimaryBankAccount(
              bankAccounts: bankAccounts,
            ),
            card: _findPrimaryCard(
              cards: cards,
            ),
            isApplePay: isApplePaySupported,
            isGooglePay: isGooglePaySupported,
            isTackBalance: state.hasEnoughTackBalance,
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
    Emitter<PayForTackState> emit,
  ) async {
    /*final PayForTackSelectedPaymentMethod? result = await _appRouter.pushForResult(
      SelectPayForTackPaymentMethodFeature.page(
        selectedPaymentMethodId: state.selectedPaymentMethodId,
      ),
    );
    emit(state.copyWith(selectedPaymentMethod: result));*/
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

  Future<void> _onMakePayForTackRequest(
    MakePayForTackRequest event,
    Emitter<PayForTackState> emit,
  ) async {
    /* try {
      _appRouter.push(ProgressDialog.page());
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
            amountInCents: state
                .amountInDollarFormatWithFee(
                  feePercent: state.fee?.stripeFeeData.feePercent ?? 0,
                  feeMinAmount: state.fee?.stripeFeeData.feeMin.toDouble() ?? 0,
                  feeMaxAmount: state.fee?.stripeFeeData.feeMax.toDouble() ?? 0,
                )
                .toCentsFormat,
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
      _appRouter.pop();
      _appRouter.push(
        PayForTackSuccessfulFeature.page(
          newTackBalance: state.userBalance.usdBalance + state.amount,
        ),
      );
    } on TransactionsLimitException {
      _appRouter.pop();
      _appRouter.push(
        PayForTackFailedFeature.page(
          errorKey: 'addToTackBalanceFailedScreen.limitReached',
        ),
      );
    } catch (e) {
      _appRouter.pop();
      _appRouter.push(
        PayForTackFailedFeature.page(
          errorKey: 'addToTackBalanceFailedScreen.unableToAdd',
        ),
      );
    }*/
  }

  Future<void> _onUserBalanceUpdate(
    UserBalanceUpdate event,
    Emitter<PayForTackState> emit,
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
