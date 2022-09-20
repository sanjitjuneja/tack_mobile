import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:domain/use_case.dart';
import 'package:navigation/navigation.dart';

import '../../account_settings/ui/account_settings_page.dart';
import '../../change_password/ui/change_password_page.dart';

part 'account_information_event.dart';

part 'account_information_state.dart';

class AccountInformationBloc
    extends Bloc<AccountInformationEvent, AccountInformationState> {
  final GlobalAppRouterDelegate _globalAppRouterDelegate;
  final AppRouterDelegate _appRouter;
  final DeleteAccountUseCase _deleteAccountUseCase;
  final LogOutUseCase _logOutUseCase;

  late StreamSubscription<User> _userSubscription;

  AccountInformationBloc({
    required GlobalAppRouterDelegate globalAppRouterDelegate,
    required AppRouterDelegate appRouter,
    required GetCurrentUserUseCase getCurrentUserUseCase,
    required ObserveUserUseCase observeUserUseCase,
    required DeleteAccountUseCase deleteAccountUseCase,
    required LogOutUseCase logOutUseCase,
  })  : _globalAppRouterDelegate = globalAppRouterDelegate,
        _appRouter = appRouter,
        _deleteAccountUseCase = deleteAccountUseCase,
        _logOutUseCase = logOutUseCase,
        super(
          AccountInformationState(
            user: getCurrentUserUseCase.execute(NoParams()),
          ),
        ) {
    on<UserChanged>(_onUserChanged);

    on<ChangeProfileAction>(_onChangeProfileAction);
    on<ChangePasswordAction>(_onChangePasswordAction);
    on<DeleteAccountAction>(_onDeleteAccountAction);

    _userSubscription = observeUserUseCase.execute(NoParams()).listen(
      (User event) {
        add(UserChanged(user: event));
      },
    );
  }

  Future<void> _onUserChanged(
    UserChanged event,
    Emitter<AccountInformationState> emit,
  ) async {
    emit(
      state.copyWith(
        user: event.user,
      ),
    );
  }

  Future<void> _onChangeProfileAction(
    ChangeProfileAction event,
    Emitter<AccountInformationState> emit,
  ) async {
    final bool? result = await _appRouter.pushForResult(
      AccountSettingsFeature.page(),
    );

    if (result == true) {
      _appRouter.pushForResult(
        AppAlertDialog.page(
          SuccessAlert(
            contentKey: 'otherAlert.userInfoChange',
          ),
        ),
      );
    }
  }

  Future<void> _onChangePasswordAction(
    ChangePasswordAction event,
    Emitter<AccountInformationState> emit,
  ) async {
    final bool? result = await _appRouter.pushForResult(
      ChangePasswordFeature.page(),
    );

    if (result == true) {
      _appRouter.pushForResult(
        AppAlertDialog.page(
          SuccessAlert(
            contentKey: 'otherAlert.passwordChange',
          ),
        ),
      );
    }
  }

  Future<void> _onDeleteAccountAction(
    DeleteAccountAction event,
    Emitter<AccountInformationState> emit,
  ) async {
    final bool? result = await _appRouter.pushForResult(
      DestructiveDialog.page(
        DestructiveAlert(
          contentKey: 'destructiveAlert.deleteAccount',
        ),
      ),
    );

    if (result != true) return;

    try {
      _appRouter.pushProgress();
      await _deleteAccountUseCase.execute(
        const DeleteAccountPayload(),
      );

      await _logOutUseCase.execute(NoParams());
      _globalAppRouterDelegate.pushForResult(
        AppAlertDialog.page(
          SuccessAlert(contentKey: 'otherAlert.accountDeleted'),
        ),
      );
    } on HasActiveTacksException catch (_) {
      _appRouter.popProgress();
      _appRouter.pushForResult(
        AppAlertDialog.page(
          ErrorAlert(
            contentKey: 'errorAlert.accountDeleteHasActiveTacks',
          ),
        ),
      );
    } on HasNotEmptyBalanceException catch (_) {
      _appRouter.popProgress();
      _appRouter.pushForResult(
        AppAlertDialog.page(
          ErrorAlert(
            contentKey: 'errorAlert.accountDeleteHasNotEmptyBalance',
          ),
        ),
      );
    } catch (e) {
      _appRouter.popProgress();
      _appRouter.pushForResult(
        AppAlertDialog.page(
          ErrorAlert(
            messageKey: e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Future<void> close() async {
    _userSubscription.cancel();

    super.close();
  }
}
