import 'dart:async';

import 'package:auth/sign_in/sign_in_feature.dart';
import 'package:auth/sign_up/personal_information/bloc/personal_information_event.dart';
import 'package:auth/sign_up/personal_information/bloc/personal_information_state.dart';
import 'package:core/core.dart';
import 'package:core/errors/existed_user_exception.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:home/home.dart';
import 'package:navigation/navigation.dart';

import '../../error_page/error_page.dart';

class PersonalInformationBloc
    extends Bloc<PersonalInformationEvent, PersonalInformationState> {
  final AppRouterDelegate appRouter;
  final SignUpUseCase signUpUseCase;
  final VerificationData verificationData;

  PasswordValidator _passwordValidator = PasswordValidator.initial();
  PasswordValidator _confirmedPasswordValidator = PasswordValidator.initial();

  PersonalInformationBloc({
    required this.appRouter,
    required this.signUpUseCase,
    required this.verificationData,
  }) : super(
          PersonalInformationState(
            passwordError: PasswordValidator.initial(),
            confirmedPasswordError: PasswordValidator.initial(),
          ),
        );

  bool isDataValid = false;
  bool isPasswordDataValid = false;

  @override
  Stream<PersonalInformationState> mapEventToState(
      PersonalInformationEvent event) async* {
    if (event is RegisterUser) {
      final Map<String, String> postValidationErrors = getPostValidation(
        email: event.email,
      );
      if (postValidationErrors.isEmpty) {
        try {
          appRouter.push(ProgressDialog.page());
          await signUpUseCase.execute(
            SignUpByPhonePayload(
              email: event.email,
              uuid: verificationData.udid,
              firstName: event.firstName,
              lastName: event.lastName,
              password: event.password,
              // phoneNumber: event.phoneNumber,
              phoneNumber: '+375295685885',
            ),
          );
          appRouter.pop();
          appRouter.push(HomeFeature.page());
        } on Exception catch (e) {
          if (e is ExistedUserException) {
            appRouter.replace(ErrorPage(
              titleKey: 'errorScreen.title',
              descriptionKey: 'errorScreen.description',
              onPressed: () {
                appRouter.push(SignInPage());
              },
            ));
          } else {
            appRouter.replace(
              AppAlertDialog.page(
                ErrorAlert(
                  contentKey: 'signUp.title',
                  messageKey: e.toString(),
                ),
              ),
            );
          }
        }
      } else {
        yield state.copyWith(
          newPostValidationErrors: postValidationErrors,
        );
      }
    }

    if (event is ValidatePassword) {
      if (event.password.isNotEmpty) {
        _passwordValidator = FieldValidator.getPasswordValidationsList(
          password: event.password,
          confirmedPassword: event.confirmedPassword,
        );
        _confirmedPasswordValidator = FieldValidator.getPasswordValidationsList(
          password: event.password,
          confirmedPassword: event.confirmedPassword,
        );

        yield state.copyWith(
          newPasswordError: _passwordValidator,
          newConfirmedPasswordError: _confirmedPasswordValidator,
        );
      } else {
        yield state.copyWith(
          newPasswordError: PasswordValidator.initial(),
        );
      }
    }

    if (event is ValidateConfirmedPassword) {
      if (event.confirmedPassword.isNotEmpty) {
        _passwordValidator = FieldValidator.getPasswordValidationsList(
          password: event.password,
          confirmedPassword: event.confirmedPassword,
        );

        _confirmedPasswordValidator = FieldValidator.getPasswordValidationsList(
          password: event.password,
          confirmedPassword: event.confirmedPassword,
        );
        yield state.copyWith(
          newPasswordError: _passwordValidator,
          newConfirmedPasswordError: _confirmedPasswordValidator,
        );
      } else {
        yield state.copyWith(
          newConfirmedPasswordError: PasswordValidator.initial(),
        );
      }
    }

    if (event is ValidateTermsConditions) {
      yield state.copyWith(
        isNewTermsAccepted: event.isConditionsAccepted,
      );
    }
  }

  //TODO: Create common solution for forgetPassword feature
  Map<String, String> getPostValidation({
    required String email,
  }) {
    Map<String, String> validations = {};
    if (email.isNotEmpty) {
      final String? emailError = FieldValidator.validateEmail(email);
      if (emailError != null) {
        validations['email'] = emailError;
      }
    }

    return validations;
  }
}
