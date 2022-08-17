import 'dart:async';
import 'package:account/account.dart';
import 'package:app_drawer/src/models/go_to_option.dart';
import 'package:core/core.dart';
import 'package:customer_support/customer_support.dart';
import 'package:domain/domain.dart';
import 'package:domain/use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:groups/groups.dart';
import 'package:navigation/navigation.dart';
import 'package:payment/payment.dart';

part 'app_drawer_event.dart';

part 'app_drawer_state.dart';

class AppDrawerBloc extends Bloc<AppDrawerEvent, AppDrawerState> {
  final AppRouterDelegate _appRouter;
  final ObserveUserUseCase _observeUserUseCase;
  final LogOutUseCase _logOutUseCase;

  late StreamSubscription<User> _userSubscription;

  AppDrawerBloc({
    required AppRouterDelegate appRouterDelegate,
    required GetCurrentUserUseCase getCurrentUserUseCase,
    required ObserveUserUseCase observeUserUseCase,
    required LogOutUseCase logOutUseCase,
  })  : _appRouter = appRouterDelegate,
        _observeUserUseCase = observeUserUseCase,
        _logOutUseCase = logOutUseCase,
        super(
          AppDrawerState(
            user: getCurrentUserUseCase.execute(NoParams()),
          ),
        ) {
    on<UserUpdate>(_onUserUpdate);
    on<GoTo>(_onGoTo);
    on<LogOut>(_onLogOut);

    _userSubscription = _observeUserUseCase.execute(NoParams()).listen(
      (User newUser) {
        final AppDrawerEvent event = UserUpdate(user: newUser);
        add(event);
      },
    );
  }

  Future<void> _onUserUpdate(
    UserUpdate event,
    Emitter<AppDrawerState> emit,
  ) async {
    emit(
      state.copyWith(user: event.user),
    );
  }

  Future<void> _onGoTo(
    GoTo event,
    Emitter<AppDrawerState> emit,
  ) async {
    switch (event.goTo) {
      case GoToOption.account:
        _appRouter.push(AccountInformationFeature.page());
        break;
      case GoToOption.groups:
        _appRouter.push(MyGroupsFeature.page());
        break;
      case GoToOption.invitations:
        _appRouter.push(InvitationsFeature.page());
        break;
      case GoToOption.previousTacks:
        _appRouter.push(PreviousTacksFeature.page());
        break;
      case GoToOption.deposit:
        // TODO: Handle this case.
        break;
      case GoToOption.withdraw:
        _appRouter.push(WithdrawFeature.page());
        break;
      case GoToOption.paymentSettings:
        _appRouter.push(PaymentSettingsFeature.page());
        break;
      case GoToOption.customerSupport:
        _appRouter.push(CustomerSupport.page());
        break;
      case GoToOption.termsAndConditions:
        UrlManager.openUrlFromTranslation(
          event.context,
          translationKey: 'urls.${event.goTo.name}',
        );
        break;
      case GoToOption.privacyPolicy:
        UrlManager.openUrlFromTranslation(
          event.context,
          translationKey: 'urls.${event.goTo.name}',
        );
        break;
    }
  }

  Future<void> _onLogOut(
    LogOut event,
    Emitter<AppDrawerState> emit,
  ) async {
    _logOutUseCase.execute(NoParams());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
