import 'package:domain/tacks/tacks.dart';
import 'package:flutter/cupertino.dart';

import 'package:tacks/src/ongoing_tack/ongoing_tacker_tack/bloc/ongoing_tacker_tack_bloc.dart';
import 'package:tacks/src/ongoing_tack/ongoing_tacker_tack/ui/widgets/ongoing_tacker_tack_offers_section.dart';
import 'package:tacks/src/ongoing_tack/ongoing_tacker_tack/ui/widgets/ongoing_tacker_tack_runner_widget.dart';

class OngoingTackerTackBody extends StatelessWidget {
  final OngoingTackerTackState state;

  const OngoingTackerTackBody({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    switch (state.tack.status) {
      case TackStatus.created:
        return const SizedBox.shrink();
      case TackStatus.pendingAccept:
        return OngoingTackerTackOffersSection(state: state);
      case TackStatus.pendingStart:
        return OngoingTackerTackRunnerWidget(
          runner: state.tack.runner!,
        );
      case TackStatus.inProgress:
        return OngoingTackerTackRunnerWidget(
          runner: state.tack.runner!,
        );
      case TackStatus.pendingReview:
        return OngoingTackerTackRunnerWidget(
          runner: state.tack.runner!,
        );
      case TackStatus.completed:
        return const SizedBox.shrink();
    }
  }
}
