import 'package:core/localization/app_localization.dart';
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
            color: AppTheme.secondaryTextColor,
          ),
        ),
        getSecondaryText(),
      ],
    );
  }

  Text getSecondaryText() {
    if (timeAgo != null) {
      return Text(
        '${timeAgo!} ${AppLocalizations.ofGlobalContext(
          'dashboard.list.ago',
        )}',
        style: AppTextTheme.manrope12Light.copyWith(
          color: AppTheme.secondaryTextColor,
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
