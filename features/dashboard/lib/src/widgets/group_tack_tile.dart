library tack_tile;

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:dashboard/dashboard.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:home/home.dart';

part 'tack_general_info_widget.dart';

part 'tack_header_widget.dart';

part 'tack_tile_actions.dart';

class GroupTackTile extends StatelessWidget {
  final GroupTack groupTack;
  final bool withActions;

  const GroupTackTile({
    super.key,
    required this.groupTack,
    this.withActions = true,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle descriptionTextStyle =
        AppTextTheme.manrope14Medium.copyWith(height: 1.5);

    return ContainerWithSeparator(
      header: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TackHeaderWidget(
            name: groupTack.tack.title,
            fee: groupTack.tack.price,
          ),
          const SizedBox(height: 10),
          TackGeneralInfoWidget(
            tack: groupTack.tack,
          ),
        ],
      ),
      footer: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (withActions) ...<Widget>[
            ExpandableText(
              text: groupTack.tack.description,
              style: descriptionTextStyle,
            ),
            const SizedBox(height: 10),
            TackTileActions(groupTack: groupTack),
          ] else
            Text(
              groupTack.tack.description,
              style: descriptionTextStyle,
            ),
        ],
      ),
    );
  }
}
