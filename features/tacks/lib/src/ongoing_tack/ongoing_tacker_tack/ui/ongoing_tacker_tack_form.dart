import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import '../bloc/ongoing_tacker_tack_bloc.dart';
import 'widgets/ongoing_tacker_tack_actions.dart';
import 'widgets/ongoing_tacker_tack_body.dart';
import '../../widgets/header_widget.dart';

class OngoingTackerTackForm extends StatelessWidget {
  const OngoingTackerTackForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OngoingTackerTackBloc, OngoingTackerTackState>(
      builder: (_, OngoingTackerTackState state) {
        if (state.isLoading) {
          return Center(
            child: AppProgressIndicator(
              backgroundColor: AppTheme.transparentColor,
            ),
          );
        } else {
          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: HeaderWidget(
                  tack: state.tack,
                  stepsCount: state.stepsCount,
                  currentStep: state.currentStep,
                  isTacker: true,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: OngoingTackerTackBody(state: state),
              ),
              OngoingTackerTackActions(
                tack: state.tack,
                padding: const EdgeInsets.only(
                  top: 6.0,
                  left: 16.0,
                  right: 16.0,
                  bottom: 12.0,
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
