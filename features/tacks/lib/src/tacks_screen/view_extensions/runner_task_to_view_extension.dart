import 'package:domain/domain.dart';

extension RunnerTackStatusToDescriptionExtension on Tack {
  String get finalDescription {
    return tacker.fullName;
  }
}
