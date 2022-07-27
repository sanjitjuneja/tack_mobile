import 'package:flutter/cupertino.dart';

import '../../core_ui.dart';

class RequiredMarkerWidget extends StatelessWidget {
  final String text;
  final String marker;

  const RequiredMarkerWidget({
    required this.text,
    this.marker = ' * ',
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          text,
          style: AppTextTheme.manrope14Bold.copyWith(
            color: AppTheme.accentColor,
          ),
        ),
        Text(
          marker,
          style: AppTextTheme.manrope14Bold.copyWith(
            color: AppTheme.errorColor,
          ),
        )
      ],
    );
  }
}
