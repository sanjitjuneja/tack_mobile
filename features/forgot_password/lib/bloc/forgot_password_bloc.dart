import 'dart:async';

import 'package:core/core.dart';
import 'package:domain/enums/phone_verification_type.dart';
import 'package:domain/models/base_error_model.dart';
import 'package:domain/models/verification_data.dart';
import 'package:home/home.dart';
import 'package:navigation/navigation.dart';
import 'package:phone_verification/phone_verification_feature.dart';

import 'forgot_password_event.dart';
import 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final GlobalAppRouterDelegate appRouter;
  final PhoneVerificationType phoneVerificationType;

  ForgotPasswordBloc({
    required this.appRouter,
    required this.phoneVerificationType,
  }) : super(ForgotPasswordState()) {
    add(
      GetVerificationCode(),
    );
  }

  @override
  Stream<ForgotPasswordState> mapEventToState(
      ForgotPasswordEvent event) async* {
    if (event is GetVerificationCode) {
      final VerificationData? result = await appRouter.pushForResult(
        PhoneVerificationFeature.page(
          phoneVerificationType: phoneVerificationType,
        ),
      );

      if (result == null) {
        appRouter.popWithResult(true);
      }
    }

    if (event is ChangePassword) {
      final Map<String, String> postValidationErrors = getPostValidation(
        password: event.password,
        confirmedPassword: event.confirmedPassword,
      );
      if (postValidationErrors.isEmpty) {
        appRouter.push(HomeFeature.page());
      } else {
        yield state.copyWith(
          newPostValidationsErrors: postValidationErrors,
        );
      }
    }

    if (event is SubmitNewPassword) {
      appRouter.push(HomeFeature.page());
    }

    if (event is ValidatePassword) {
      final List<BaseErrorModel> errors =
          FieldValidator.getPasswordValidationsList(event.password);

      yield state.copyWith(newPasswordErrors: errors);
    }

    if (event is ValidateConfirmedPassword) {
      final List<BaseErrorModel> errors =
          FieldValidator.getPasswordValidationsList(event.password);

      yield state.copyWith(newConfirmedPasswordErrors: errors);
    }
  }

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
