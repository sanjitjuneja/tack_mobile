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
  final TackModel tack;
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
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
