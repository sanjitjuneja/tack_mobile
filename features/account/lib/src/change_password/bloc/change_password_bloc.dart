import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';

part 'change_password_event.dart';

part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final GlobalAppRouterDelegate _appRouter;
  final ChangePasswordUseCase _changePasswordUseCase;

  ChangePasswordBloc({
    required GlobalAppRouterDelegate appRouter,
    required ChangePasswordUseCase changePasswordUseCase,
  })  : _appRouter = appRouter,
        _changePasswordUseCase = changePasswordUseCase,
        super(
          ChangePasswordState(
            oldPasswordData: const OldPasswordData(),
            passwordData: const PasswordData(),
            passwordConfirmationData: const PasswordConfirmationData(),
            passwordsValidator: PasswordValidator.initial(),
          ),
        ) {
    on<OldPasswordChanged>(_onOldPasswordChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<PasswordConfirmationChanged>(_onPasswordConfirmationChanged);

    on<SubmitNewPasswordAction>(_onSubmitNewPassword);
  }

  Future<void> _onOldPasswordChanged(
    OldPasswordChanged event,
    Emitter<ChangePasswordState> emit,
  ) async {
    emit(
      state.copyWith(
        oldPassword: event.password,
        passwordsValidator: PasswordValidator.validate(
          password: state.passwordData.password,
          passwordConfirmation: state.passwordConfirmationData.password,
          oldPassword: event.password,
        ),
      ),
    );
  }

  Future<void> _onPasswordChanged(
    PasswordChanged event,
    Emitter<ChangePasswordState> emit,
  ) async {
    emit(
      state.copyWith(
        password: event.password,
        passwordsValidator: PasswordValidator.validate(
          password: event.password,
          passwordConfirmation: state.passwordConfirmationData.password,
          oldPassword: state.oldPasswordData.password,
        ),
      ),
    );
  }

  Future<void> _onPasswordConfirmationChanged(
    PasswordConfirmationChanged event,
    Emitter<ChangePasswordState> emit,
  ) async {
    emit(
      state.copyWith(
        passwordConfirmation: event.password,
        passwordsValidator: PasswordValidator.validate(
          password: state.passwordData.password,
          passwordConfirmation: event.password,
          oldPassword: state.oldPasswordData.password,
        ),
      ),
    );
  }

  Future<void> _onSubmitNewPassword(
    SubmitNewPasswordAction event,
    Emitter<ChangePasswordState> emit,
  ) async {
    if (!state.isReadyToProceed) {
      return emit(
        state.copyWith(
          isValidationEnabled: true,
        ),
      );
    }

    try {
      _appRouter.pushProgress();
      await _changePasswordUseCase.execute(
        ChangePasswordPayload(
          oldPassword: state.oldPasswordData.password,
          newPassword: state.passwordData.password,
        ),
      );
      _appRouter.popProgress();
      _appRouter.popWithResult(true);
    } on WrongPasswordException catch (_) {
      _appRouter.popProgress();
      emit(
        state.copyWith(isOldPasswordInvalid: true),
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
}
