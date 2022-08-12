import 'package:domain/tacks/tacks.dart';
import 'package:flutter/cupertino.dart';

import 'package:tacks/src/ongoing_tack/ongoing_tacker_tack/bloc/ongoing_tacker_tack_bloc.dart';
import 'package:tacks/src/ongoing_tack/ongoing_tacker_tack/ongoing_tacker_tack_offers_section/ui/ongoing_tacker_tack_offers_section.dart';
import 'package:tacks/src/ongoing_tack/ongoing_tacker_tack/ui/widgets/ongoing_tacker_tack_runner_widget.dart';
import 'package:tacks/src/ongoing_tack/widgets/tack_details_section.dart';

class OngoingTackerTackBody extends StatelessWidget {
  final OngoingTackerTackState state;

  const OngoingTackerTackBody({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    const EdgeInsets padding = EdgeInsets.only(
      top: 10.0,
      left: 16.0,
      right: 16.0,
      bottom: 20.0,
    );

    final Widget? child;

    switch (state.tack.status) {
      case TackStatus.created:
        child = null;
        break;
      case TackStatus.pendingAccept:
        return OngoingTackerTackOffersSection(
          state: state,
          padding: padding,
        );
      case TackStatus.pendingStart:
        child = OngoingTackerTackRunnerWidget(
          runner: state.tack.runner!,
        );
        break;
      case TackStatus.inProgress:
        child = OngoingTackerTackRunnerWidget(
          runner: state.tack.runner!,
        );
        break;
      case TackStatus.pendingReview:
        child = OngoingTackerTackRunnerWidget(
          runner: state.tack.runner!,
        );
        break;
      case TackStatus.completed:
        return const SizedBox.shrink();
    }

    return SafeArea(
      child: Padding(
        padding: padding,
        child: Column(
          children: <Widget>[
            if (child != null) ...<Widget>[
              child,
              const SizedBox(height: 30),
            ],
            TackDetailSection(
              tack: state.tack,
              hasDeleteAction: false,
            ),
          ],
        ),
      ),
    );
  }
}
