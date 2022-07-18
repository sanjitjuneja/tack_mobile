import 'package:flutter/material.dart';

import '../../core_ui.dart';

class LifterWidget extends StatelessWidget {
  const LifterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 5,
      decoration: BoxDecoration(
        color: AppTheme.bottomSheetLift,
        borderRadius: const BorderRadius.all(
          Radius.circular(30),
        ),
      ),
    );
  }
}
