import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class SplashForm extends StatelessWidget {
  const SplashForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Spacer(flex: 2),
        Center(
          child: AppImagesTheme.appLogo,
        ),
        const Spacer(flex: 3),
      ],
    );
  }
}
