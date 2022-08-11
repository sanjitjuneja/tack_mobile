import 'dart:async';

import 'package:auth/sign_in/bloc/sign_in_event.dart';
import 'package:auth/sign_in/bloc/sign_in_state.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/foundation.dart';
import 'package:forgot_password/forgot_password_page.dart';
import 'package:navigation/navigation.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final GlobalAppRouterDelegate appRouter;
  final SignInUseCase signInUseCase;

  SignInBloc({
    required this.appRouter,
    required this.signInUseCase,
  }) : super(const SignInState());

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    if (event is SignIn) {
      try {
        appRouter.push(ProgressDialog.page());
        final String phoneNumber;
        final String password;

        if (kDebugMode) {
          phoneNumber = '+18096666919';
          password = 'Tackapp123';
        } else {
          phoneNumber = '+${event.phoneNumber}';
          password = event.password;
        }

        await signInUseCase.execute(
          SignInPayload(
            password: password,
            phoneNumber: phoneNumber,
          ),
        );
        appRouter.pop();
        appRouter.popWithResult(true);
      } on Exception catch (e) {
        appRouter.pop();
        appRouter.pushForResult(
          AppAlertDialog.page(
            ErrorAlert(
              contentKey: 'signIn.signIn',
              messageKey: e.toString(),
            ),
          ),
        );
      }
    }

    if (event is RouteBack) {
      appRouter.popWithResult(false);
    }

    if (event is UpdateData) {
      final bool isDataValid = _validateData(
        password: event.password,
        phoneNumber: event.phoneNumber,
      );

      yield state.copyWith(
        isDataValid: isDataValid,
      );
    }

    if (event is RouteToForgotPassword) {
      final result = await appRouter.pushForResult(
        ForgotPasswordPage(
          phoneVerificationType: PhoneVerificationType.forgotPassword,
        ),
      );
    }
  }

  bool _validateData({
    required String password,
    required String phoneNumber,
  }) {
    /// TODO: refactor validation.
    // final bool isPasswordValid = FieldValidator.validatePassword(password);
    // final bool isPhoneValid = FieldValidator.validatePhoneNumber(phoneNumber);
    //
    // if (isPhoneValid && isPasswordValid) {
    //   return true;
    // } else {
    //   return false;
    // }
    return true;
  }
}
