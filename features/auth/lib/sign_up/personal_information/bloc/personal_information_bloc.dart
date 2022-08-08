import 'dart:async';

import 'package:auth/sign_up/personal_information/bloc/personal_information_event.dart';
import 'package:auth/sign_up/personal_information/bloc/personal_information_state.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:home/home.dart';
import 'package:navigation/navigation.dart';

class PersonalInformationBloc
    extends Bloc<PersonalInformationEvent, PersonalInformationState> {
  final AppRouterDelegate appRouter;
  final SignUpUseCase signUpUseCase;
  final VerificationData verificationData;

  PersonalInformationBloc({
    required this.appRouter,
    required this.signUpUseCase,
    required this.verificationData,
  }) : super(PersonalInformationState());

  bool isDataValid = false;
  bool isPasswordDataValid = false;

  @override
  Stream<PersonalInformationState> mapEventToState(
      PersonalInformationEvent event) async* {
    if (event is RegisterUser) {
      final Map<String, String> postValidationErrors = getPostValidation(
        password: event.password,
        confirmedPassword: event.confirmedPassword,
      );

      if (postValidationErrors.isEmpty) {
        try {
          appRouter.push(ProgressDialog.page());
          await signUpUseCase.execute(
            SignUpByPhonePayload(
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
        } catch (e) {
          appRouter.push(
            AppAlertDialog.page(
              ErrorAlert(
                contentKey: 'signUp.title',
                messageKey: e.toString(),
              ),
            ),
          );
        }
      } else {
        yield state.copyWith(
          newPostValidationErrors: postValidationErrors,
        );
      }
    }

    if (event is ValidateFirstName) {
      final List<BaseErrorModel> validations =
          FieldValidator.getNameValidationsList(
        event.firstName,
      );

      yield state.copyWith(
        newFirstNameError: validations,
      );
    }

    if (event is ValidateLastName) {
      final List<BaseErrorModel> validations =
          FieldValidator.getNameValidationsList(
        event.lastName,
      );

      yield state.copyWith(
        newSecondNameError: validations,
      );
    }

    if (event is ValidatePassword) {
      final List<BaseErrorModel> validations =
          FieldValidator.getPasswordValidationsList(
        event.password,
      );

      yield state.copyWith(
        newPasswordError: validations,
      );
    }

    if (event is ValidateConfirmedPassword) {
      final List<BaseErrorModel> validations =
          FieldValidator.getPasswordValidationsList(
        event.password,
      );

      yield state.copyWith(
        newConfirmedPasswordError: validations,
      );
    }

    if (event is ValidateTermsConditions) {
      yield state.copyWith(
        isNewTermsAccepted: event.isConditionsAccepted,
      );
    }

    if (event is RouteBack) {
      appRouter.pop();
    }
  }

  //TODO: Create common solution for forgetPassword feature
  Map<String, String> getPostValidation({
    required String password,
    required String confirmedPassword,
  }) {
    if (password == confirmedPassword) {
      return <String, String>{};
    } else {
      return <String, String>{
        'password': 'Passwords do not match',
        'confirmedPassword': 'Passwords do not match',
      };
    }
  }
}
