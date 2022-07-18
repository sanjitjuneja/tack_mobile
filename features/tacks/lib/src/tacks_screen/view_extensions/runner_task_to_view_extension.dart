
import 'package:domain/domain.dart';

extension RunnerTackStatusToDescriptionExtension on RunnerTack {
  String get finalDescription {
    return creator.name;
  }
}