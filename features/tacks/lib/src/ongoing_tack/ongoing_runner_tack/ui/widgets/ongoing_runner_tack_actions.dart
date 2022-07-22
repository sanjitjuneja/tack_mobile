import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

import 'package:tacks/src/ongoing_tack/ongoing_runner_tack/bloc/ongoing_runner_tack_bloc.dart';
import 'package:tacks/src/ongoing_tack/view_extensions/ongoing_tack_to_view_extension.dart';
import 'package:tacks/src/ongoing_tack/widgets/note_widget.dart';

class OngoingRunnerTackActions extends StatelessWidget {
  final OngoingRunnerTackState  state;

  const OngoingRunnerTackActions({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final Tack tack = state.tack;

    switch (tack.status) {
      case TackStatus.created:
        return const SizedBox.shrink();
      case TackStatus.pendingAccept:
        return const SizedBox.shrink();
      case TackStatus.pendingStart:
        return Column(
          children: <Widget>[
            AppCircleButton(
              labelKey: tack.status.getButtonLabel(isTacker: false),
              isDisabled: state.hasRunningTack,
            ),
            if (state.hasRunningTack) ...<Widget>[
              const SizedBox(height: 12),
              NoteWidget(
                contentKey: tack.status.getNoteText(isTacker: false),
              ),
            ],
          ],
        );
      case TackStatus.inProgress:
        return Column(
          children: <Widget>[
            AppCircleButton(
              labelKey: tack.status.getButtonLabel(isTacker: false),
            ),
            const SizedBox(height: 12),
            NoteWidget(
              contentKey: tack.status.getNoteText(isTacker: false),
            ),
          ],
        );
      case TackStatus.pendingReview:
        return NoteWidget(
          contentKey: tack.status.getNoteText(isTacker: false),
        );
      case TackStatus.completed:
        return const SizedBox.shrink();
    }
  }
}
