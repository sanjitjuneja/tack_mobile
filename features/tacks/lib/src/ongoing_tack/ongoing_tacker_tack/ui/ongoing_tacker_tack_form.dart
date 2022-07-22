import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';

import 'package:tacks/src/ongoing_tack/ongoing_tacker_tack/bloc/ongoing_tacker_tack_bloc.dart';
import 'package:tacks/src/ongoing_tack/ongoing_tacker_tack/ui/widgets/ongoing_tacker_tack_actions.dart';
import 'package:tacks/src/ongoing_tack/ongoing_tacker_tack/ui/widgets/ongoing_tacker_tack_body.dart';
import 'package:tacks/src/ongoing_tack/widgets/header_widget.dart';
import 'package:tacks/src/ongoing_tack/widgets/tack_details_section.dart';

class OngoingTackerTackForm extends StatelessWidget {
  const OngoingTackerTackForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OngoingTackerTackBloc, OngoingTackerTackState>(
      builder: (_, OngoingTackerTackState state) {
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
              child: CupertinoScrollbar(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    left: 16.0,
                    right: 16.0,
                    bottom: 20.0,
                  ),
                  child: SafeArea(
                    child: Column(
                      children: <Widget>[
                        OngoingTackerTackBody(state: state),
                        const SizedBox(height: 30),
                        TackDetailSection(
                          tack: state.tack,
                          hasDeleteAction: false,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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
      },
    );
  }
}
