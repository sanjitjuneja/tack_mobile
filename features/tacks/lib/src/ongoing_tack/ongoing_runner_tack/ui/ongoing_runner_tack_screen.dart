import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import 'package:tacks/src/ongoing_tack/ongoing_runner_tack/bloc/ongoing_runner_tack_bloc.dart';
import 'package:tacks/src/ongoing_tack/ongoing_runner_tack/ui/ongoing_runner_tack_form.dart';

class OngoingRunnerTackScreen extends StatelessWidget {
  const OngoingRunnerTackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.backgroundColor,
      navigationBar: AppNavigationBar(
        backgroundColor: AppTheme.backgroundColor,
        actions: <Widget>[
          AppButton(
            labelKey: 'ongoingTackScreen.contactTackerButton',
            icon: AppIconsTheme.phone,
            type: ButtonType.secondary,
            expanded: false,
            onTap: () => _onContactButtonTap(context),
          ),
        ],
      ),
      child: const SafeArea(
        child: OngoingRunnerTackForm(),
      ),
    );
  }

  void _onContactButtonTap(BuildContext context) {
    BlocProvider.of<OngoingRunnerTackBloc>(context).add(const ContactTacker());
  }
}
