import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import 'package:tacks/src/ongoing_tack/ongoing_tacker_tack/bloc/ongoing_tacker_tack_bloc.dart';
import 'package:tacks/src/ongoing_tack/ongoing_tacker_tack/ui/ongoing_tacker_tack_form.dart';

class OngoingTackerTackScreen extends StatelessWidget {
  const OngoingTackerTackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.backgroundColor,
      navigationBar: AppNavigationBar(
        backgroundColor: AppTheme.backgroundColor,
        actions: <Widget>[
          BlocBuilder<OngoingTackerTackBloc, OngoingTackerTackState>(
            bloc: BlocProvider.of<OngoingTackerTackBloc>(context),
            builder: (_, OngoingTackerTackState state) {
              if (state.tack.canTackerCancel) {
                return NavigationBarActionButton(
                  labelKey: 'ongoingTackScreen.cancelTackButton',
                  onTap: _onCancelButtonPressed,
                );
              } else {
                return NavigationBarActionButton(
                  labelKey: 'ongoingTackScreen.contactRunnerButton',
                  icon: AppIconsTheme.phone,
                  onTap: _onContactButtonPressed,
                );
              }
            },
          ),
        ],
      ),
      child: const OngoingTackerTackForm(),
    );
  }

  void _onCancelButtonPressed(BuildContext context) {
    BlocProvider.of<OngoingTackerTackBloc>(context).add(const CancelTack());
  }

  void _onContactButtonPressed(BuildContext context) {
    BlocProvider.of<OngoingTackerTackBloc>(context).add(const ContactRunner());
  }
}
