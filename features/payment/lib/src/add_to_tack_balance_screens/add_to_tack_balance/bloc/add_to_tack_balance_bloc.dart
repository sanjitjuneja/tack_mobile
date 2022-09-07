import 'dart:async';

import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:domain/use_case.dart';
import 'package:navigation/navigation.dart';
import 'package:payment/src/add_to_tack_balance_screens/select_payment_method_screen/ui/select_payment_method_page.dart';

import '../../add_to_tack_balance_successful/ui/add_to_tack_balance_successful_page.dart';
import '../../models/selected_payment_method.dart';

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
  })  : _appRouter = appRouter,
        _fetchConnectedBankAccountsUseCase = fetchConnectedBankAccountsUseCase,
        _fetchConnectedCardsUseCase = fetchConnectedCardsUseCase,
        _observeUserBalanceUseCase = observeUserBalanceUseCase,
        _fetchUserBalanceUseCase = fetchUserBalanceUseCase,
        _fetchIsApplePaySupportedUseCase = fetchIsApplePaySupportedUseCase,
        _fetchIsGooglePaySupportedUseCase = fetchIsGooglePaySupportedUseCase,
        super(
          AddToTackBalanceState(
            amount: 0.0,
            userBalance: getUserBalanceUseCase.execute(NoParams()),
            selectedPaymentMethod: const SelectedPaymentMethod(
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
        final AddToTackBalanceEvent event = UserBalanceUpdate(
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

      emit(
        state.copyWith(
          selectedPaymentMethod: SelectedPaymentMethod(
            bankAccount: _findPrimaryBankAccount(
              bankAccounts: bankAccounts,
            ),
            card: _findPrimaryCard(
              cards: cards,
            ),
            isApplePay: isApplePaySupported,
            isGooglePay: isGooglePaySupported,
          ),
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
    final String? selectedPaymentMethodId =
        state.selectedPaymentMethod.card != null
            ? state.selectedPaymentMethod.card!.id
            : state.selectedPaymentMethod.bankAccount != null
                ? state.selectedPaymentMethod.bankAccount!.id
                : state.selectedPaymentMethod.isApplePay
                    ? Constants.applePayId
                    : state.selectedPaymentMethod.isGooglePay
                        ? Constants.googlePayId
                        : null;

    final SelectedPaymentMethod? result = await _appRouter.pushForResult(
      SelectPaymentMethodFeature.page(
        selectedPaymentMethodId: selectedPaymentMethodId,
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
    _appRouter.replace(AddToTackBalanceSuccessfulFeature.page());
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
