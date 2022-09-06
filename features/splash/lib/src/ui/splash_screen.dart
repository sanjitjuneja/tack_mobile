import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'splash_form.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: const SplashForm(),
    );
  }
}
