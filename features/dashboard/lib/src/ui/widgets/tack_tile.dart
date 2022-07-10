import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

import 'package:dashboard/src/ui/widgets/tack_general_info_widget.dart';
import 'package:dashboard/src/ui/widgets/tack_tile_actions.dart';
import 'package:dashboard/src/ui/widgets/tack_header_widget.dart';

class TackTile extends StatelessWidget {
  final TackModel tack;

  const TackTile({
    super.key,
    required this.tack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: AppTheme.shadowColor,
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TackHeaderWidget(
                  name: tack.name,
                  fee: tack.fee,
                ),
                const SizedBox(height: 10),
                TackGeneralInfoWidget(tack: tack),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const AppDivider(),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ExpandableText(text: tack.description),
                const SizedBox(height: 10),
                const TackTileActions(),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
