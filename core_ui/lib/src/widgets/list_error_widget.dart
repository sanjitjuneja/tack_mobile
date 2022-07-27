import 'package:domain/models/base_error_model.dart';
import 'package:flutter/material.dart';

import '../../core_ui.dart';

class ListErrorWidget extends StatelessWidget {
  List<BaseErrorModel> errors;

  ListErrorWidget({
    required this.errors,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 0),
      itemBuilder: (BuildContext context, int index) {
        return Row(
          children: <Widget>[
            AppIconsTheme.cross(
              color: AppTheme.errorColor,
            ),
            const SizedBox(width: 11),
            Text(
              errors[index].errorText,
              style: AppTextTheme.manrope14Medium.copyWith(
                color: AppTheme.accentColor,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              errors[index].descriptionText ?? '',
              style: AppTextTheme.manrope14Medium.copyWith(
                color: AppTheme.textDisabledColor,
              ),
            ),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox.shrink();
      },
      itemCount: errors.length,
    );
  }
}
