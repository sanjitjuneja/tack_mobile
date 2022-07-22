import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

class OngoingTackerTackRunnerWidget extends StatelessWidget {
  final TackUser runner;

  const OngoingTackerTackRunnerWidget({
    super.key,
    required this.runner,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 20.0,
        top: 20.0,
        bottom: 20.0,
        right: 16.0,
      ),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: WidgetShadowType.heavy.shadow,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              runner.fullName,
              style: AppTextTheme.manrope16Bold
                  .copyWith(color: AppTheme.textPrimaryColor),
            ),
          ),
          const SizedBox(width: 6),
          UserStatsWidget.fromTackUser(tackUser: runner),
        ],
      ),
    );
  }
}
