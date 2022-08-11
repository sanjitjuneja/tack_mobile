import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:tacks/src/ongoing_tack/ongoing_tacker_tack/bloc/ongoing_tacker_tack_bloc.dart';

import 'package:tacks/src/ongoing_tack/view_extensions/ongoing_tack_to_view_extension.dart';
import 'package:tacks/src/ongoing_tack/widgets/note_widget.dart';

class OngoingTackerTackActions extends StatelessWidget {
  final Tack tack;
  final EdgeInsets padding;

  const OngoingTackerTackActions({
    super.key,
    required this.tack,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    switch (tack.status) {
      case TackStatus.created:
        return SafeArea(
          top: false,
          child: AppCircleButton(
            margin: padding,
            labelKey: tack.status.getButtonLabel(isTacker: true),
            withFeedback: true,
            onTap: () => _onActionPressed(context),
          ),
        );
      case TackStatus.pendingAccept:
        return const SizedBox.shrink();
      case TackStatus.pendingStart:
        return const SizedBox.shrink();
      case TackStatus.inProgress:
        return const SizedBox.shrink();
      case TackStatus.pendingReview:
        return SafeArea(
          top: false,
          child: Padding(
            padding: padding,
            child: Column(
              children: <Widget>[
                AppCircleButton(
                  labelKey: tack.status.getButtonLabel(isTacker: true),
                  withFeedback: true,
                  onTap: () => _onActionPressed(context),
                ),
                const SizedBox(height: 12),
                NoteWidget(
                  contentKey: tack.status.getNoteText(isTacker: true),
                ),
              ],
            ),
          ),
        );
      case TackStatus.completed:
        return const SizedBox.shrink();
    }
  }

  void _onActionPressed(BuildContext context) {
    BlocProvider.of<OngoingTackerTackBloc>(context).add(const ActionPressed());
  }
}
