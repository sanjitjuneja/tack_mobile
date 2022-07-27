import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';
import 'package:tacks/src/ongoing_tack/ongoing_runner_tack/ui/ongoing_runner_tack_page.dart';
import 'package:tacks/src/tacks_screen/ui/widgets/runner_tack/runner_task_actions.dart';
import 'package:tacks/src/tacks_screen/ui/widgets/tack_header_widget.dart';

class RunnerTackWidget extends StatelessWidget {
  final RunnerTack runnerTack;

  const RunnerTackWidget({
    super.key,
    required this.runnerTack,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: runnerTack.isTracking ? () => _onTap(context) : null,
      child: Container(
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
              opacity:
                  runnerTack.tack.status == TackStatus.pendingAccept ? 0.5 : 1,
              child: TackHeaderWidget(
                tack: runnerTack.tack,
              ),
            ),
            const SizedBox(height: 30),
            Flexible(
              child: RunnerTackActions(runnerTack: runnerTack),
            ),
          ],
        ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    AppRouter.of(context).push(OngoingRunnerTack.page(tack: runnerTack.tack));
  }
}
