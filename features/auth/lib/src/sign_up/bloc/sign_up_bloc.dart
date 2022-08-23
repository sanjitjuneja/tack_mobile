import 'dart:async';

import 'package:auth/src/sign_up/models/email_data.dart';
import 'package:auth/src/sign_up/models/first_name_data.dart';
import 'package:auth/src/sign_up/models/last_name_data.dart';
import 'package:auth/src/sign_up/models/terms_data.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';
import 'package:phone_verification/phone_verification.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final GlobalAppRouterDelegate _appRouter;
  final SignUpUseCase _signUpUseCase;

  SignUpBloc({
    required PhoneVerificationData phoneVerificationData,
    required GlobalAppRouterDelegate appRouter,
    required SignUpUseCase signUpUseCase,
  })  : _appRouter = appRouter,
        _signUpUseCase = signUpUseCase,
        super(
          SignUpState(
            phoneVerificationData: phoneVerificationData,
            firstNameData: const FirstNameData(),
            lastNameData: const LastNameData(),
            emailData: const EmailData(),
            termsData: const TermsData(),
            passwordData: const PasswordData(
              validator: FieldValidator.isPasswordLengthValid,
            ),
            passwordConfirmationData: const PasswordConfirmationData(
              validator: FieldValidator.isPasswordLengthValid,
            ),
            passwordsValidator: PasswordValidator.initial(),
          ),
        ) {
    on<FirstNameChanged>(_onFirstNameChanged);
    on<LastNameChanged>(_onLastNameChanged);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<PasswordConfirmationChanged>(_onPasswordConfirmationChanged);
    on<TermsAndConditionsChanged>(_onTermsAndConditionsChanged);

    on<RegisterUserAction>(_onRegisterUserAction);
  }

  Future<void> _onFirstNameChanged(
    FirstNameChanged event,
    Emitter<SignUpState> emit,
  ) async {
    emit(
      state.copyWith(
        firstName: event.firstName,
      ),
    );
  }

  Future<void> _onLastNameChanged(
    LastNameChanged event,
    Emitter<SignUpState> emit,
  ) async {
    emit(
      state.copyWith(
        lastName: event.lastName,
      ),
    );
  }

  Future<void> _onEmailChanged(
    EmailChanged event,
    Emitter<SignUpState> emit,
  ) async {
    emit(
      state.copyWith(
        email: event.email,
      ),
    );
  }

  Future<void> _onPasswordChanged(
    PasswordChanged event,
    Emitter<SignUpState> emit,
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
    Emitter<SignUpState> emit,
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

  Future<void> _onTermsAndConditionsChanged(
    TermsAndConditionsChanged event,
    Emitter<SignUpState> emit,
  ) async {
    emit(
      state.copyWith(
        isTermsAccepted: event.isAccepted,
      ),
    );
  }

  Future<void> _onRegisterUserAction(
    RegisterUserAction event,
    Emitter<SignUpState> emit,
  ) async {
    if (!state.isReadyToProceed) {
      emit(
        state.copyWith(isValidationEnabled: true),
      );

      return;
    }

    try {
      _appRouter.push(ProgressDialog.page());
      await _signUpUseCase.execute(
        SignUpByPhonePayload(
          email: state.emailData.email,
          uuid: state.phoneVerificationData.udid,
          firstName: state.firstNameData.firstName,
          lastName: state.lastNameData.lastName,
          password: state.passwordData.password,
          phoneNumber: state.phoneVerificationData.phoneNumber,
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
