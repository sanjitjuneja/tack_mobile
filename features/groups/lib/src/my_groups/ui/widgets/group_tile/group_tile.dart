import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

import 'package:groups/src/my_groups/bloc/groups_bloc.dart';
import 'package:groups/src/my_groups/ui/widgets/group_tile/group_tile_actions.dart';

class GroupTile extends StatelessWidget {
  final Group group;

  const GroupTile({
    super.key,
    required this.group,
  });

  @override
  Widget build(BuildContext context) {
    return OpacityOnTapContainer(
      onTap: () => _onTilePressed(context),
      child: Container(
        padding: const EdgeInsets.only(
          top: 14.0,
          left: 16.0,
          right: 8.0,
          bottom: 16.0,
        ),
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
            AppCircleAvatarWidget(
              group.imageUrl,
              isShadowBorder: false,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    group.name,
                    style: AppTextTheme.manrope16Bold
                        .copyWith(color: AppTheme.textPrimaryColor),
                  ),
                  const SizedBox(height: 6),
                  GroupTileActions(group: group),
                ],
              ),
            ),
            const SizedBox(width: 2),
            AppIconsTheme.chevronRight(color: AppTheme.iconSecondaryColor),
          ],
        ),
      ),
    );
  }

  void _onTilePressed(BuildContext context) {
    BlocProvider.of<GroupsBloc>(context).add(OpenGroupDetails(group: group));
  }
}
