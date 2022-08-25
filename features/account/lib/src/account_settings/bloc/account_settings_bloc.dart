import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:domain/use_case.dart';
import 'package:navigation/navigation.dart';

part 'account_settings_event.dart';

part 'account_settings_state.dart';

class AccountSettingsBloc
    extends Bloc<AccountSettingsEvent, AccountSettingsState> {
  final AppRouterDelegate _appRouter;
  final UpdateUserInfoUseCase _updateUserInfoUseCase;

  AccountSettingsBloc({
    required AppRouterDelegate appRouter,
    required GetCurrentUserUseCase getCurrentUserUseCase,
    required UpdateUserInfoUseCase updateUserInfoUseCase,
  })  : _appRouter = appRouter,
        _updateUserInfoUseCase = updateUserInfoUseCase,
        super(
          AccountSettingsState.fromUser(
            user: getCurrentUserUseCase.execute(NoParams()),
          ),
        ) {
    on<FirstNameChanged>(_onFirstNameChanged);
    on<LastNameChanged>(_onLastNameChanged);
    on<EmailChanged>(_onEmailChanged);

    on<UpdateProfileAction>(_onUpdateProfileAction);
  }

  Future<void> _onFirstNameChanged(
    FirstNameChanged event,
    Emitter<AccountSettingsState> emit,
  ) async {
    emit(
      state.copyWith(
        firstName: event.firstName,
      ),
    );
  }

  Future<void> _onLastNameChanged(
    LastNameChanged event,
    Emitter<AccountSettingsState> emit,
  ) async {
    emit(
      state.copyWith(
        lastName: event.lastName,
      ),
    );
  }

  Future<void> _onEmailChanged(
    EmailChanged event,
    Emitter<AccountSettingsState> emit,
  ) async {
    emit(
      state.copyWith(
        email: event.email,
      ),
    );
  }

  Future<void> _onUpdateProfileAction(
    UpdateProfileAction event,
    Emitter<AccountSettingsState> emit,
  ) async {
    if (!state.isReadyToProceed) {
      return emit(
        state.copyWith(isValidationEnabled: true),
      );
    }

    if (!state.isAnyDataChanged) {
      return _appRouter.popWithResult(false);
    }

    try {
      _appRouter.push(ProgressDialog.page());
      await _updateUserInfoUseCase.execute(
        UpdateUserInfoPayload(
          firstName: state.changedFirstName,
          lastName: state.changedLastName,
          email: state.changedEmail,
        ),
      );
      _appRouter.pop();
      _appRouter.popWithResult(true);
    } on EmailAlreadyUsedException catch (_) {
      _appRouter.pop();
      emit(state.copyWith(isEmailAlreadyUsed: true));
    } catch (e) {
      _appRouter.pop();
      _appRouter.pushForResult(
        AppAlertDialog.page(
          ErrorAlert(
            messageKey: e.toString(),
          ),
        ),
      );
    }
  }
}
