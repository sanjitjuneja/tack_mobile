import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

import 'package:tacks/src/ongoing_tack/widgets/tack_info/tack_info_widget.dart';

class TackDetailSection extends StatelessWidget {
  final Tack tack;
  final bool hasDeleteAction;

  // only for runner;
  final VoidCallback? onDeletePressed;

  const TackDetailSection({
    super.key,
    required this.tack,
    required this.hasDeleteAction,
    this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          FlutterI18n.translate(
            context,
            'ongoingTackScreen.tackDetails',
          ),
          style: AppTextTheme.manrope20Regular
              .copyWith(color: AppTheme.textPrimaryColor),
        ),
        const SizedBox(height: 20),
        TackInfoWidget(
          tack: tack,
          hasDeleteAction: hasDeleteAction,
          onDeletePressed: onDeletePressed,
        ),
      ],
    );
  }
}
