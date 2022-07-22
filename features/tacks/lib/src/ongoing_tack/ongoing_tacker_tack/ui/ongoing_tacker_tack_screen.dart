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
            builder: (_, OngoingTackerTackState state) {
              if (state.tack.canTackerCancel) {
                return AppButton(
                  labelKey: 'ongoingTackScreen.cancelTackButton',
                  type: ButtonType.secondary,
                  expanded: false,
                  onTap: () => _onCancelButtonTap(context),
                );
              } else {
                return AppButton(
                  labelKey: 'ongoingTackScreen.contactRunnerButton',
                  icon: AppIconsTheme.phone,
                  type: ButtonType.secondary,
                  expanded: false,
                  onTap: () => _onContactButtonTap(context),
                );
              }
            },
          ),
        ],
      ),
      child: const OngoingTackerTackForm(),
    );
  }

  void _onCancelButtonTap(BuildContext context) {
    BlocProvider.of<OngoingTackerTackBloc>(context).add(const CancelTack());
  }

  void _onContactButtonTap(BuildContext context) {
    BlocProvider.of<OngoingTackerTackBloc>(context).add(const ContactRunner());
  }
}
