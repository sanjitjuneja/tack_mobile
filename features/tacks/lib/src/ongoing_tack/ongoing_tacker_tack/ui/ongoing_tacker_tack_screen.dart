import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import '../../widgets/contact_tack_user_widget.dart';
import '../bloc/ongoing_tacker_tack_bloc.dart';
import 'ongoing_tacker_tack_form.dart';

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
                return ContactTackUserWidget(
                  isLoading: state.isContactsLoading,
                  hasData: state.hasContactData,
                  onCallPressed: _onContactPhoneButtonPressed,
                  onChatPressed: _onContactMessageButtonPressed,
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

  void _onContactMessageButtonPressed(BuildContext context) {
    BlocProvider.of<OngoingTackerTackBloc>(context).add(const MessageRunner());
  }

  void _onContactPhoneButtonPressed(BuildContext context) {
    BlocProvider.of<OngoingTackerTackBloc>(context).add(const CallRunner());
  }
}
