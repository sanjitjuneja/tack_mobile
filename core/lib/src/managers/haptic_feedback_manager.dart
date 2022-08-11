import 'package:flutter/services.dart';

enum HapticFeedbackType {
  heavy,
  medium,
  light,
  success,
  error,
}

class HapticFeedbackManager {
  static Future<void> feedback({required HapticFeedbackType type}) {
    switch (type) {
      case HapticFeedbackType.heavy:
        return HapticFeedbackManager.heavyImpact();
      case HapticFeedbackType.medium:
        return HapticFeedbackManager.mediumImpact();
      case HapticFeedbackType.light:
        return HapticFeedbackManager.lightImpact();
      case HapticFeedbackType.success:
        return HapticFeedbackManager.success();
      case HapticFeedbackType.error:
        return HapticFeedbackManager.error();
    }
  }

  static Future<void> heavyImpact() async {
    HapticFeedback.heavyImpact();
  }

  static Future<void> mediumImpact() async {
    HapticFeedback.mediumImpact();
  }

  static Future<void> lightImpact() async {
    HapticFeedback.lightImpact();
  }

  static Future<void> success() async {
    HapticFeedback.heavyImpact();
    await Future.delayed(const Duration(milliseconds: 170));
    HapticFeedback.mediumImpact();
  }

  static Future<void> error() async {
    HapticFeedback.heavyImpact();
    await Future.delayed(const Duration(milliseconds: 100));
    HapticFeedback.heavyImpact();
    await Future.delayed(const Duration(milliseconds: 140));
    HapticFeedback.heavyImpact();
  }
}
