import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

class GroupMemberTile extends StatelessWidget {
  final TackUser member;

  const GroupMemberTile({
    super.key,
    required this.member,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppTheme.shadowColor,
            offset: const Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              member.fullName,
              style: AppTextTheme.manrope16Bold
                  .copyWith(color: AppTheme.textPrimaryColor),
            ),
          ),
          const SizedBox(width: 8),
          UserStatsWidget.fromTackUser(tackUser: member),
        ],
      ),
    );
  }
}
