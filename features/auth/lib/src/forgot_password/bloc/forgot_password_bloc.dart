import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';
import 'package:phone_verification/phone_verification.dart';

part 'forgot_password_event.dart';

part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final GlobalAppRouterDelegate _appRouter;
  final ChangePasswordRecoveryUseCase _changePasswordRecoveryUseCase;

  ForgotPasswordBloc({
    required PhoneVerificationData phoneVerificationData,
    required GlobalAppRouterDelegate appRouter,
    required ChangePasswordRecoveryUseCase changePasswordRecoveryUseCase,
  })  : _appRouter = appRouter,
        _changePasswordRecoveryUseCase = changePasswordRecoveryUseCase,
        super(
          ForgotPasswordState(
            phoneVerificationData: phoneVerificationData,
            passwordData: const PasswordData(),
            passwordConfirmationData: const PasswordConfirmationData(),
            passwordsValidator: PasswordValidator.initial(),
          ),
        ) {
    on<PasswordChanged>(_onPasswordChanged);
    on<PasswordConfirmationChanged>(_onPasswordConfirmationChanged);

    on<SubmitNewPasswordAction>(_onSubmitNewPassword);
  }

  Future<void> _onPasswordChanged(
    PasswordChanged event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(
      state.copyWith(
        password: event.password,
        passwordsValidator: PasswordValidator.validate(
          password: event.password,
          passwordConfirmation: state.passwordConfirmationData.password,
        ),
      ),
    );
  }

  Future<void> _onPasswordConfirmationChanged(
    PasswordConfirmationChanged event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(
      state.copyWith(
        passwordConfirmation: event.password,
        passwordsValidator: PasswordValidator.validate(
          password: state.passwordData.password,
          passwordConfirmation: event.password,
        ),
      ),
    );
  }

  Future<void> _onSubmitNewPassword(
    SubmitNewPasswordAction event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    if (!state.isReadyToProceed) {
      emit(
        state.copyWith(isValidationEnabled: true),
      );

      return;
    }

    try {
      _appRouter.push(ProgressDialog.page());
      await _changePasswordRecoveryUseCase.execute(
        RecoveryChangePasswordPayload(
          uuid: state.phoneVerificationData.udid,
          password: state.passwordData.password,
        ),
      );
      _appRouter.pop();
      _appRouter.popWithResult(true);
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
