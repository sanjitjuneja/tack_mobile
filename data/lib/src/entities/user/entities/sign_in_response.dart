part of user_entities;

class SignInResponse {
  final Response response;
  final domain.Message message;

  SignInResponse({
    required this.response,
    required this.message,
  });
}
