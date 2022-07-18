import 'package:domain/models/user.dart';

class SignUpParams {
  final User user;
  final String uuid;

  SignUpParams({
    required this.user,
    required this.uuid,
  });
}

extension SignUpParamsExt on SignUpParams {
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'user': user.toMap(),
    };
  }
}
