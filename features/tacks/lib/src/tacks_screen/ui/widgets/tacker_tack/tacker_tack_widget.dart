import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:tacks/src/tacks_screen/ui/widgets/tack_header_widget.dart';
import 'package:tacks/src/tacks_screen/ui/widgets/tacker_tack/tacker_tack_actions.dart';
import 'package:tacks/src/tacks_screen/view_extensions/tacker_task_to_view_extensions.dart';

class TackerTackWidget extends StatelessWidget {
  final TackerTack tack;

  const TackerTackWidget({
    super.key,
    required this.tack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
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
      child: Column(
        children: <Widget>[
          TackHeaderWidget(
            name: tack.name,
            fee: tack.fee,
            estimatedTime: tack.estimatedTime,
            description: tack.finalDescription,
            descriptionStyle: tack.descriptionTextStyle,
          ),
          const SizedBox(height: 30),
          TackerTackActions(tack: tack),
        ],
      ),
    );
  }
}
