import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../core_ui.dart';

class TackTimeWidget extends StatelessWidget {
  final String time;
  final String? timeAgo;
  final String? tackerName;

  const TackTimeWidget({
    required this.time,
    this.timeAgo,
    this.tackerName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          time,
          style: AppTextTheme.manrope12Light.copyWith(
            color: AppTheme.textSecondaryColor,
          ),
        ),
        getSecondaryText(context),
      ],
    );
  }

  Text getSecondaryText(BuildContext context) {
    if (timeAgo != null) {
      return Text(
        '${timeAgo!} ${FlutterI18n.translate(context, 'general.ago')}',
        style: AppTextTheme.manrope12Light.copyWith(
          color: AppTheme.textSecondaryColor,
        ),
      );
    } else if (tackerName != null) {
      return Text(
        tackerName!,
        style: AppTextTheme.manrope12Bold.copyWith(
          color: AppTheme.accentColor,
        ),
      );
    } else {
      return const Text('');
    }
  }
}
