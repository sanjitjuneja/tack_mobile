import 'dart:async';

import 'package:core/core.dart';
import 'package:domain/use_case.dart';
import 'package:navigation/navigation.dart';
import 'package:domain/domain.dart';

import '../../../payment_settings_screens/add_credit_card/ui/add_credit_card_page.dart';
import '../../../payment_settings_screens/add_payment_method_screens/add_payment_method/models/add_payment_method_screen_result.dart';
import '../../../payment_settings_screens/add_payment_method_screens/add_payment_method/ui/add_payment_method_page.dart';
import '../../../payment_settings_screens/add_payment_method_screens/add_payment_method_failed/ui/add_payment_method_failed_page.dart';
import '../../models/pay_for_tack_selected_payment_method.dart';

part 'select_pay_for_tack_payment_method_event.dart';

part 'select_pay_for_tack_payment_method_state.dart';

class SelectPayForTackPaymentMethodBloc extends Bloc<
    SelectPayForTackPaymentMethodEvent, SelectPayForTackPaymentMethodState> {
  final AppRouterDelegate _appRouter;
  final FetchConnectedBankAccountsUseCase _fetchConnectedBankAccountsUseCase;
  final FetchConnectedCardsUseCase _fetchConnectedCardsUseCase;
  final FetchIsApplePaySupportedUseCase _fetchIsApplePaySupportedUseCase;
  final FetchIsGooglePaySupportedUseCase _fetchIsGooglePaySupportedUseCase;
  final ObserveUserBalanceUseCase _observeUserBalanceUseCase;
  final FetchUserBalanceUseCase _fetchUserBalanceUseCase;
  final FetchFeeUseCase _feeUseCase;
  final AddBankAccountUseCase _addBankAccountUseCase;

  late StreamSubscription<UserBankAccount> _userBalanceSubscription;

  SelectPayForTackPaymentMethodBloc({
    required AppRouterDelegate appRouter,
    required FetchConnectedBankAccountsUseCase
        fetchConnectedBankAccountsUseCase,
    required FetchConnectedCardsUseCase fetchConnectedCardsUseCase,
    required FetchIsApplePaySupportedUseCase fetchIsApplePaySupportedUseCase,
    required FetchIsGooglePaySupportedUseCase fetchIsGooglePaySupportedUseCase,
    required ObserveUserBalanceUseCase observeUserBalanceUseCase,
    required FetchUserBalanceUseCase fetchUserBalanceUseCase,
    required GetUserBalanceUseCase getUserBalanceUseCase,
    required FetchFeeUseCase feeUseCase,
    required String? selectedPaymentMethodId,
    required double offerPrice,
    required AddBankAccountUseCase addBankAccountUseCase,
  })  : _appRouter = appRouter,
        _fetchConnectedBankAccountsUseCase = fetchConnectedBankAccountsUseCase,
        _fetchConnectedCardsUseCase = fetchConnectedCardsUseCase,
        _observeUserBalanceUseCase = observeUserBalanceUseCase,
        _fetchUserBalanceUseCase = fetchUserBalanceUseCase,
        _fetchIsApplePaySupportedUseCase = fetchIsApplePaySupportedUseCase,
        _fetchIsGooglePaySupportedUseCase = fetchIsGooglePaySupportedUseCase,
        _feeUseCase = feeUseCase,
        _addBankAccountUseCase = addBankAccountUseCase,
        super(
          SelectPayForTackPaymentMethodState(
            bankAccounts: <ConnectedBankAccount>[],
            cards: <ConnectedCard>[],
            offerPrice: offerPrice,
            userBalance: getUserBalanceUseCase.execute(NoParams()),
            selectedPaymentMethodId: selectedPaymentMethodId,
            fee: null,
          ),
        ) {
    on<InitialLoad>(_onInitialLoad);

    on<SelectPayForTackPaymentMethodAction>(
      _onSelectPayForTackPaymentMethodAction,
    );
    on<AddPaymentMethodAction>(_onAddPaymentMethodAction);
    on<AddBankAction>(_onAddBankAction);
    on<AddCardAction>(_onAddCardAction);
    on<ContinueAction>(_onContinueAction);

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

      await _fetchUserBalanceUseCase.execute(const FetchUserBalancePayload());

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

  Future<void> _onAddBankAction(
    AddBankAction event,
    Emitter<SelectPayForTackPaymentMethodState> emit,
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
    Emitter<SelectPayForTackPaymentMethodState> emit,
  ) async {
    final bool? result = await _appRouter.pushForResult(
      AddCreditCardFeature.page(),
    );
    if (result == true) {
      add(const InitialLoad());
    }
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

  Future<void> _onContinueAction(
    ContinueAction event,
    Emitter<SelectPayForTackPaymentMethodState> emit,
  ) async {
    _appRouter.popWithResult(
      state.selectedPaymentMethod,
    );
  }

  Future<void> _onUserBalanceUpdate(
    UserBalanceUpdate event,
    Emitter<SelectPayForTackPaymentMethodState> emit,
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
