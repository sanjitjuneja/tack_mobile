import 'package:flutter/material.dart';

import '../../core_ui.dart';

class PageAppBar extends StatelessWidget {
  final String? text;
  final Image? avatar;

  const PageAppBar({
    this.text,
    this.avatar,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        if (avatar != null) ...<Widget>{
          AppImagesTheme.avatar,
        } else if (text != null) ...<Widget>{
          Text(
            text!,
            style: AppTextTheme.manrope20Medium.copyWith(
              color: AppTheme.accentColor,
            ),
          ),
        },
        const Spacer(),
        AppImagesTheme.chat,
        const SizedBox(width: 19),
        AppImagesTheme.bell,
        const SizedBox(width: 19),
        AppImagesTheme.burger,
      ],
    );
  }
}
