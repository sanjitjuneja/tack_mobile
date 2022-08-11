import 'package:flutter/cupertino.dart';

import 'package:groups/src/group_details/ui/widgets/group_details_actions.dart';
import 'package:groups/src/group_details/ui/widgets/group_info/group_info_widget.dart';
import 'package:groups/src/group_details/ui/widgets/group_users/group_members_widget.dart';

class GroupDetailsFrom extends StatelessWidget {
  const GroupDetailsFrom({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        SizedBox(height: 20),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16.0),
          child:  GroupInfoWidget(),
        ),
        SizedBox(height: 20),
        Expanded(
          child: GroupMembersWidget(),
        ),
        SizedBox(height: 6),
        GroupDetailsActions(),
        SizedBox(height: 6),
      ],
    );
  }
}
