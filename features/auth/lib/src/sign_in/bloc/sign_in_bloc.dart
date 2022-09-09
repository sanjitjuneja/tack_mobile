import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/foundation.dart';
import 'package:navigation/navigation.dart';
import 'package:phone_verification/phone_verification.dart';

import '../../forgot_password/ui/forgot_password_page.dart';
import '../../sign_up/ui/sign_up_page.dart';

part 'sign_in_event.dart';

part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final GlobalAppRouterDelegate _appRouter;
  final SignInUseCase _signInUseCase;

  SignInBloc({
    required GlobalAppRouterDelegate appRouter,
    required SignInUseCase signInUseCase,
  })  : _appRouter = appRouter,
        _signInUseCase = signInUseCase,
        super(
          const SignInState(
            loginData: LoginData(),
            passwordData: PasswordData(),
          ),
        ) {
    on<LoginChanged>(_onLoginChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<SignInAction>(_onSignInAction);

    on<ForgotPasswordAction>(_onForgotPasswordAction);
    on<SignUpAction>(_onSignUpAction);
  }

  Future<void> _onLoginChanged(
    LoginChanged event,
    Emitter<SignInState> emit,
  ) async {
    emit(
      state.copyWith(
        login: event.login,
      ),
    );
  }

  Future<void> _onPasswordChanged(
    PasswordChanged event,
    Emitter<SignInState> emit,
  ) async {
    emit(
      state.copyWith(
        password: event.password,
      ),
    );
  }

  Future<void> _onSignInAction(
    SignInAction event,
    Emitter<SignInState> emit,
  ) async {
    if (!kDebugMode && !state.isReadyToProceed) {
      return emit(
        state.copyWith(
          isValidationEnabled: true,
        ),
      );
    }

    try {
      _appRouter.push(ProgressDialog.page());
      final String login;
      final String password;

      if (kDebugMode && !state.loginData.isValid ||
          !state.passwordData.isValid) {
        login = '+375295555555';
        password = 'Tackapp123';
      } else {
        login = FieldValidator.adjustToAmericanNumberIfNeeded(
          state.loginData.login,
        );
        password = state.passwordData.password;
      }

      await _signInUseCase.execute(
        SignInPayload(
          password: password,
          login: login,
        ),
      );
      _appRouter.pop();
      _appRouter.popWithResult(true);
    } on WrongCredentialsException catch (_) {
      _appRouter.pop();
      emit(
        state.copyWith(wrongCredentials: true),
      );
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

  Future<void> _onForgotPasswordAction(
    ForgotPasswordAction event,
    Emitter<SignInState> emit,
  ) async {
    final PhoneVerificationScreenResult? phoneVerificationScreenResult =
        await _appRouter.pushForResult(
      PhoneVerificationFeature.pageForForgotPassword(),
    );

    if (phoneVerificationScreenResult == null) return;

    if (phoneVerificationScreenResult.shouldOpenSignUp) {
      add(const SignUpAction());
    } else {
      final bool? result = await _appRouter.pushForResult(
        ForgotPasswordFeature.page(
          phoneVerificationData:
              phoneVerificationScreenResult.phoneVerificationData!,
        ),
      );

      if (result == true) {
        _appRouter.pushForResult(
          AppAlertDialog.page(
            SuccessAlert(
              contentKey: 'otherAlert.recoveryPassword',
            ),
          ),
        );
      }
    }
  }

  Future<void> _onSignUpAction(
    SignUpAction event,
    Emitter<SignInState> emit,
  ) async {
    final PhoneVerificationScreenResult? phoneVerificationScreenResult =
        await _appRouter.pushForResult(
      PhoneVerificationFeature.pageForSignUp(),
    );

    if (phoneVerificationScreenResult == null) return;

    if (phoneVerificationScreenResult.shouldOpenSignIn) return;

    final bool? result = await _appRouter.pushForResult(
      SignUpFeature.page(
        phoneVerificationData:
            phoneVerificationScreenResult.phoneVerificationData!,
      ),
    );

    if (result == true) {
      _appRouter.popWithResult(true);
    }
  }
}
