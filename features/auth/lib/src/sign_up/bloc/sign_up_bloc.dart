import 'dart:async';

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
  final SignInUseCase _signInUseCase;

  SignUpBloc({
    required PhoneVerificationData phoneVerificationData,
    required GlobalAppRouterDelegate appRouter,
    required SignUpUseCase signUpUseCase,
    required SignInUseCase signInUseCase,
  })  : _appRouter = appRouter,
        _signUpUseCase = signUpUseCase,
        _signInUseCase = signInUseCase,
        super(
          SignUpState(
            phoneVerificationData: phoneVerificationData,
            firstNameData: const FirstNameData(),
            lastNameData: const LastNameData(),
            emailData: const EmailData(),
            termsData: const TermsData(),
            passwordData: const PasswordData(),
            passwordConfirmationData: const PasswordConfirmationData(),
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
      return emit(
        state.copyWith(
          isValidationEnabled: true,
        ),
      );
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
      await _signInUseCase.execute(
        SignInPayload(
          password: state.passwordData.password,
          login: state.phoneVerificationData.phoneNumber,
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
