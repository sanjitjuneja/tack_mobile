import '../user_model.dart';

class TackModel {
  final String name;
  final double fee;
  final Duration estimatedTime;
  final UserModel user;
  final String description;

  const TackModel({
    required this.name,
    required this.fee,
    required this.estimatedTime,
    required this.user,
    required this.description,
  });
}
