import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';

import 'package:tacks/src/ongoing_tack/ongoing_runner_tack/bloc/ongoing_runner_tack_bloc.dart';
import 'package:tacks/src/ongoing_tack/ongoing_runner_tack/ui/widgets/ongoing_runner_tack_actions.dart';
import 'package:tacks/src/ongoing_tack/widgets/header_widget.dart';
import 'package:tacks/src/ongoing_tack/widgets/tack_details_section.dart';

class OngoingRunnerTackForm extends StatelessWidget {
  const OngoingRunnerTackForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OngoingRunnerTackBloc, OngoingRunnerTackState>(
      builder: (_, OngoingRunnerTackState state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: <Widget>[
              HeaderWidget(
                tack: state.tack,
                stepsCount: state.stepsCount,
                currentStep: state.currentStep,
                isTacker: false,
              ),
              const SizedBox(height: 30),
              TackDetailSection(
                tack: state.tack,
                hasDeleteAction: state.tack.canRunnerCancel,
                onDeletePressed: () => _onCancelTackPressed(context),
              ),
              const SizedBox(height: 10),
              const Spacer(),
              OngoingRunnerTackActions(state: state),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  void _onCancelTackPressed(BuildContext context) {
    BlocProvider.of<OngoingRunnerTackBloc>(context).add(const CancelTack());
  }
}
