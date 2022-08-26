part of 'sign_in_bloc.dart';

class SignInState {
  final LoginData loginData;
  final PasswordData passwordData;
  final bool wrongCredentials;

  bool get isReadyToProceed => loginData.isValid && passwordData.isValid;

  const SignInState({
    required this.loginData,
    required this.passwordData,
    this.wrongCredentials = false,
  });

  SignInState copyWith({
    String? login,
    String? password,
    bool? isValidationEnabled,
    bool? wrongCredentials,
  }) {
    return SignInState(
      loginData: loginData.copyWith(
        login: login,
        isValidationEnabled: isValidationEnabled,
      ),
      passwordData: passwordData.copyWith(
        password: password,
        isValidationEnabled: isValidationEnabled,
      ),
      wrongCredentials: wrongCredentials ?? false,
    );
  }
}
