class SignInParams {
  final String password;
  final String phoneNumber;

  SignInParams({
    required this.password,
    required this.phoneNumber,
  });
}

extension SignInParamsExt on SignInParams {
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'password': password,
      'phoneNumber': phoneNumber,
    };
  }
}
