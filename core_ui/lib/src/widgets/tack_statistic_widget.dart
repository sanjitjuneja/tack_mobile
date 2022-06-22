import 'package:flutter/material.dart';

import '../../core_ui.dart';

class TackStatisticWidget extends StatelessWidget {
  final Image image;
  final String value;
  final String? description;

  const TackStatisticWidget({
    required this.image,
    required this.value,
    this.description,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        image,
        const SizedBox(width: 6),
        description == null
            ? Text(
                value,
                style: AppTextTheme.manrope13SemiBold.copyWith(
                  color: AppTheme.accentColor,
                ),
              )
            : Text(
                '$value $description',
                style: AppTextTheme.manrope13SemiBold.copyWith(
                  color: AppTheme.accentColor,
                ),
              ),
      ],
    );
  }
}
