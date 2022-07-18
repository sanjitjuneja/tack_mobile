import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InviteMembersHeaderWidget extends StatelessWidget {
  const InviteMembersHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppTheme.shadowColor,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          FlutterI18n.translate(
            context,
            'inviteMembersScreen.title',
          ),
          style: AppTextTheme.manrope20Medium,
        ),
      ],
    );
  }
}
