import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../widgets/contact_tack_user_widget.dart';
import '../bloc/ongoing_runner_tack_bloc.dart';
import 'ongoing_runner_tack_form.dart';

class OngoingRunnerTackScreen extends StatelessWidget {
  const OngoingRunnerTackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: AppTheme.backgroundColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: CupertinoPageScaffold(
        backgroundColor: AppTheme.backgroundColor,
        navigationBar: AppNavigationBar(
          backgroundColor: AppTheme.backgroundColor,
          actions: <Widget>[
            BlocBuilder<OngoingRunnerTackBloc, OngoingRunnerTackState>(
              bloc: BlocProvider.of<OngoingRunnerTackBloc>(context),
              builder: (_, OngoingRunnerTackState state) {
                return ContactTackUserWidget(
                  isLoading: state.isContactsLoading,
                  hasData: state.hasContactData,
                  onCallPressed: _onContactPhoneButtonPressed,
                  onChatPressed: _onContactMessageButtonPressed,
                );
              },
            ),
          ],
        ),
        child: const SafeArea(
          child: OngoingRunnerTackForm(),
        ),
      ),
    );
  }

  void _onContactMessageButtonPressed(BuildContext context) {
    BlocProvider.of<OngoingRunnerTackBloc>(context).add(const MessageTacker());
  }

  void _onContactPhoneButtonPressed(BuildContext context) {
    BlocProvider.of<OngoingRunnerTackBloc>(context).add(const CallTacker());
  }
}
