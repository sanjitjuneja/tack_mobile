import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:tacks/src/tacks_screen/ui/widgets/runner_tack/runner_task_actions.dart';
import 'package:tacks/src/tacks_screen/ui/widgets/tack_header_widget.dart';
import 'package:tacks/src/tacks_screen/view_extensions/runner_task_to_view_extension.dart';

class RunnerTackWidget extends StatelessWidget {
  final RunnerTack tack;

  const RunnerTackWidget({
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
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Opacity(
            opacity: tack.status == RunnerTackStatus.pendingAccept ? 0.5 : 1,
            child: TackHeaderWidget(
              name: tack.name,
              fee: tack.fee,
              estimatedTime: tack.estimatedTime,
              description: tack.finalDescription,
            ),
          ),
          const SizedBox(height: 30),
          Flexible(
            child: RunnerTackActions(tack: tack),
          ),
        ],
      ),
    );
  }
}
