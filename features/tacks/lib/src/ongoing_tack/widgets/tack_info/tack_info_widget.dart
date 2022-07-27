import 'package:core/utils/currency_utils.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

part 'tack_info_header_widget.dart';

part 'tack_user_info_widget.dart';

class TackInfoWidget extends StatelessWidget {
  final Tack tack;
  final bool hasDeleteAction;
  final VoidCallback? onDeletePressed;

  const TackInfoWidget({
    super.key,
    required this.tack,
    required this.hasDeleteAction,
    this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return ContainerWithSeparator(
      shadowType: WidgetShadowType.light,
      header: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TackInfoHeaderWidget(tack: tack),
          const SizedBox(height: 10),
          TackUserInfoWidget(
            tack: tack,
            hasDeleteAction: hasDeleteAction,
            onDeletePressed: onDeletePressed,
          ),
        ],
      ),
      footer: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            tack.description,
            style: AppTextTheme.manrope14Medium.copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }
}
