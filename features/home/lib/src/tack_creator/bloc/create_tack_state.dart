import 'package:domain/models/create_tack_model.dart';

abstract class CreateTackState {}

class CreateTackLoading extends CreateTackState {}

class CreateTackContent extends CreateTackState {
  final bool isPopularTabOpened;
  final List<CreateTackModel> tacks;

  CreateTackContent({
    required this.tacks,
    required this.isPopularTabOpened,
  });
}

class CreateTackError extends CreateTackState {}
