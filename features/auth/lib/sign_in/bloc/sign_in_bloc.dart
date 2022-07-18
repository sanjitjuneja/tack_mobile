import 'dart:async';

import 'package:auth/sign_in/bloc/sign_in_event.dart';
import 'package:auth/sign_in/bloc/sign_in_state.dart';
import 'package:core/core.dart';
import 'package:core/errors/form_field_exception.dart';
import 'package:domain/params_models/sign_in_params.dart';
import 'package:domain/usecases/sign_in_usecase.dart';
import 'package:forgot_password/forgot_password_page.dart';
import 'package:home/home.dart';
import 'package:navigation/navigation.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AppRouterDelegate appRouter;
  final SignInUseCase signInUseCase;

  SignInBloc({
    required this.appRouter,
    required this.signInUseCase,
  }) : super(SignInContent(
          isDataValid: false,
        ));

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    if (event is SignIn) {
      try {
        //TODO: Add loader
        await signInUseCase.execute(
          SignInParams(
            password: event.password,
            phoneNumber: event.phoneNumber,
          ),
        );

        print('done');

        appRouter.push(
          HomeFeature.page(),
        );
      } on Exception catch (e) {
        if (e is FormFieldException) {
          yield SignInContent(
            isDataValid: true,
            errors: e.validationErrors,
          );
        }
      }
    }

    if (event is RouteBack) {
      appRouter.popWithResult(true);
    }

    if (event is UpdateData) {
      final bool isDataValid = _validateData(
        password: event.password,
        phoneNumber: event.phoneNumber,
      );

      yield SignInContent(
        isDataValid: isDataValid,
      );
    }

    if (event is RouteToForgotPassword) {
      appRouter.push(
        ForgotPasswordPage(),
      );
    }
  }

  bool _validateData({
    required String password,
    required String phoneNumber,
  }) {
    final bool isPasswordValid = FieldValidator.validatePassword(password);
    final bool isPhoneValid = FieldValidator.validatePhoneNumber(phoneNumber);

    if (isPhoneValid && isPasswordValid) {
      return true;
    } else {
      return false;
    }
  }
}
