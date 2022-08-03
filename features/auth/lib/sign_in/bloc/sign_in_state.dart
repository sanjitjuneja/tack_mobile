class SignInState {
  final bool isDataValid;
  final Map<String, String>? errors;

  const SignInState({
    this.isDataValid = false,
    this.errors,
  });

  SignInState copyWith({
    bool? isDataValid,
    Map<String, String>? errors,
  }) {
    return SignInState(
      isDataValid: isDataValid ?? this.isDataValid,
      errors: errors,
    );
  }
}
