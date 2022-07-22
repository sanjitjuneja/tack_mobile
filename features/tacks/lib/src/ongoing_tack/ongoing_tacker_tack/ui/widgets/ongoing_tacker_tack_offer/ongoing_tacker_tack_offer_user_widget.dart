import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

class OngoingTackerTackOfferUserWidget extends StatelessWidget {
  final TackUser runner;

  const OngoingTackerTackOfferUserWidget({
    super.key,
    required this.runner,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          runner.fullName,
          style: AppTextTheme.manrope16Bold
              .copyWith(color: AppTheme.textPrimaryColor),
        ),
        const SizedBox(height: 6),
        UserStatsWidget.fromTackUser(tackUser: runner),
      ],
    );
  }
}
