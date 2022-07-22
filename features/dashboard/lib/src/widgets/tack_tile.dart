library tack_tile;

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:dashboard/dashboard.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

part 'tack_general_info_widget.dart';
part 'tack_header_widget.dart';
part 'tack_tile_actions.dart';

class TackTile extends StatelessWidget {
  final Tack tack;
  final bool withActions;

  const TackTile({
    super.key,
    required this.tack,
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
            name: tack.title,
            fee: tack.price,
          ),
          const SizedBox(height: 10),
          TackGeneralInfoWidget(tack: tack),
        ],
      ),
      footer: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (withActions) ...<Widget>[
            ExpandableText(
              text: tack.description,
              style: descriptionTextStyle,
            ),
            const SizedBox(height: 10),
            TackTileActions(tack: tack),
          ] else
            Text(
              tack.description,
              style: descriptionTextStyle,
            ),
        ],
      ),
    );
  }
}
