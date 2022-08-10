import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InviteMembersHeaderWidget extends StatelessWidget {
  final Group group;

  const InviteMembersHeaderWidget({
    super.key,
    required this.group,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        AppCircleAvatarWidget(group.imageUrl),
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
