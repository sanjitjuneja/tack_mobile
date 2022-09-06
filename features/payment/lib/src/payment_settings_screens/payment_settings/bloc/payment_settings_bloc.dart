import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/use_case.dart';
import 'package:navigation/navigation.dart';
import 'package:payment/payment.dart';
import 'package:domain/domain.dart';

import '../models/payment_method_details_screen_result.dart';

part 'payment_settings_event.dart';

part 'payment_settings_state.dart';

class PaymentSettingsBloc
    extends Bloc<PaymentSettingsEvent, PaymentSettingsState> {
  final AppRouterDelegate _appRouter;
  final FetchConnectedBankAccountsUseCase _fetchConnectedBankAccountsUseCase;
  final FetchConnectedCardsUseCase _fetchConnectedCardsUseCase;
  final ObserveUserBalanceUseCase _observeUserBalanceUseCase;
  final FetchUserBalanceUseCase _fetchUserBalanceUseCase;
  final FetchIsApplePaySupportedUseCase _fetchIsApplePaySupportedUseCase;
  final FetchIsGooglePaySupportedUseCase _fetchIsGooglePaySupportedUseCase;

  late StreamSubscription<UserBankAccount> _userBalanceSubscription;

  PaymentSettingsBloc({
    required AppRouterDelegate appRouter,
    required FetchConnectedBankAccountsUseCase
        fetchConnectedBankAccountsUseCase,
    required FetchConnectedCardsUseCase fetchConnectedCardsUseCase,
    required ObserveUserBalanceUseCase observeUserBalanceUseCase,
    required FetchUserBalanceUseCase fetchUserBalanceUseCase,
    required GetUserBalanceUseCase getUserBalanceUseCase,
    required FetchIsApplePaySupportedUseCase fetchIsApplePaySupportedUseCase,
    required FetchIsGooglePaySupportedUseCase fetchIsGooglePaySupportedUseCase,
  })  : _appRouter = appRouter,
        _fetchConnectedBankAccountsUseCase = fetchConnectedBankAccountsUseCase,
        _fetchConnectedCardsUseCase = fetchConnectedCardsUseCase,
        _observeUserBalanceUseCase = observeUserBalanceUseCase,
        _fetchUserBalanceUseCase = fetchUserBalanceUseCase,
        _fetchIsApplePaySupportedUseCase = fetchIsApplePaySupportedUseCase,
        _fetchIsGooglePaySupportedUseCase = fetchIsGooglePaySupportedUseCase,
        super(
          PaymentSettingsState(
            bankAccounts: <ConnectedBankAccount>[],
            cards: <ConnectedCard>[],
            userBalance: getUserBalanceUseCase.execute(NoParams()),
          ),
        ) {
    on<InitialLoad>(_onInitialLoad);

    on<AddCashAction>(_onAddCashAction);
    on<PayoutAction>(_onPayloadAction);
    on<AddPaymentMethodAction>(_onAddPaymentMethodAction);
    on<PaymentMethodDetailsAction>(_onPaymentMethodDetailsAction);

    on<UserBalanceUpdate>(_onUserBalanceUpdate);

    _userBalanceSubscription =
        _observeUserBalanceUseCase.execute(NoParams()).listen(
      (UserBankAccount newUserBalance) {
        final PaymentSettingsEvent event = UserBalanceUpdate(
          userBalance: newUserBalance,
        );
        add(event);
      },
    );

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

      await _fetchUserBalanceUseCase.execute(const FetchUserBalancePayload());

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
    final AddPaymentMethodScreenResult? result = await _appRouter.pushForResult(
      AddPaymentMethodFeature.page(
        bankAccountsAmount: state.bankAccounts.length,
      ),
    );
    if (result != null) {
      add(const InitialLoad());
      _appRouter.pushForResult(
        AppAlertDialog.page(
          SuccessAlert(
            contentKey: result == AddPaymentMethodScreenResult.card
                ? 'otherAlert.cardAddedAlert'
                : 'otherAlert.bankAddedAlert',
          ),
        ),
      );
    }
  }

  Future<void> _onPaymentMethodDetailsAction(
    PaymentMethodDetailsAction event,
    Emitter<PaymentSettingsState> emit,
  ) async {
    PaymentMethodDetailsScreenResult? result;
    if (event.card != null) {
      result = await _appRouter.pushForResult(
        PaymentMethodDetailsFeature.cardDetailsPage(
          card: event.card!,
        ),
      );
    } else {
      result = await _appRouter.pushForResult(
        PaymentMethodDetailsFeature.bankDetailsPage(
          bankAccount: event.bankAccount!,
        ),
      );
    }
    if (result != null) {
      add(const InitialLoad());
      if (result == PaymentMethodDetailsScreenResult.removedPaymentMethod) {
        _appRouter.pushForResult(
          AppAlertDialog.page(
            SuccessAlert(
              contentKey: 'otherAlert.paymentMethodRemovedAlert',
            ),
          ),
        );
      } else if (result ==
          PaymentMethodDetailsScreenResult.removedPrimaryPaymentMethod) {
        _appRouter.pushForResult(
          AppAlertDialog.page(
            SuccessAlert(
              contentKey: 'otherAlert.paymentPrimaryMethodRemovedAlert',
            ),
          ),
        );
      } else {
        _appRouter.pushForResult(
          AppAlertDialog.page(
            SuccessAlert(
              contentKey: 'otherAlert.primaryPaymentMethodSelectedAlert',
            ),
          ),
        );
      }
    }
  }

  Future<void> _onUserBalanceUpdate(
    UserBalanceUpdate event,
    Emitter<PaymentSettingsState> emit,
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
