import 'package:flutter/services.dart';

class HapticFeedbackManager {
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
