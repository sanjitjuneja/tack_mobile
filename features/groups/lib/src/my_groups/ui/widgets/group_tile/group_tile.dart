import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

import '../../../bloc/my_groups_bloc.dart';
import 'group_tile_actions.dart';

class GroupTile extends StatelessWidget {
  final GroupDetails groupDetails;

  const GroupTile({
    super.key,
    required this.groupDetails,
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
            AppNetworkImageWidget(
              groupDetails.group.imageUrl,
              placeholderIcon: null,
              isShadowBorder: false,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    groupDetails.group.name,
                    style: AppTextTheme.manrope16Bold
                        .copyWith(color: AppTheme.textPrimaryColor),
                  ),
                  const SizedBox(height: 6),
                  GroupTileActions(groupDetails: groupDetails),
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
    BlocProvider.of<MyGroupsBloc>(context).add(
      OpenGroupDetails(groupDetails: groupDetails),
    );
  }
}
