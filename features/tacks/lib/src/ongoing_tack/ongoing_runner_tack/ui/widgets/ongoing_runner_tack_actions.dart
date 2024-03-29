import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

import '../../bloc/ongoing_runner_tack_bloc.dart';
import '../../../view_extensions/ongoing_tack_to_view_extension.dart';
import '../../../widgets/note_widget.dart';

class OngoingRunnerTackActions extends StatelessWidget {
  final OngoingRunnerTackState state;

  const OngoingRunnerTackActions({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final Tack tack = state.runnerTack.tack;

    switch (tack.status) {
      case TackStatus.created:
        return const SizedBox.shrink();
      case TackStatus.pendingAccept:
        return const SizedBox.shrink();
      case TackStatus.pendingStart:
        return Column(
          children: <Widget>[
            if (state.runningTackData.isLoading) ...<Widget>[
              AppProgressIndicator(
                indicatorSize: ProgressIndicatorSize.medium,
                backgroundColor: AppTheme.transparentColor,
              ),
            ] else if (state.runningTackData.hasError) ...<Widget>[
              const SizedBox.shrink(),
            ] else ...<Widget>[
              AppCircleButton(
                labelKey: tack.status.getButtonLabel(isTacker: false),
                isDisabled: state.runningTackData.hasRunningTack,
                withFeedback: true,
                onTap: () => _onActionPressed(context),
              ),
              if (state.runningTackData.hasRunningTack) ...<Widget>[
                const SizedBox(height: 12),
                NoteWidget(
                  contentKey: tack.status.getNoteText(isTacker: false),
                ),
              ],
            ],
          ],
        );
      case TackStatus.inProgress:
        return Column(
          children: <Widget>[
            AppCircleButton(
              labelKey: tack.status.getButtonLabel(isTacker: false),
              withFeedback: true,
              onTap: () => _onActionPressed(context),
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

  void _onActionPressed(BuildContext context) {
    BlocProvider.of<OngoingRunnerTackBloc>(context).add(const ActionPressed());
  }
}
