import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import 'package:tacks/src/add_edit_tack/bloc/add_edit_tack_bloc.dart';

class NavigationBarAction extends StatelessWidget {
  const NavigationBarAction({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditTackBloc, AddEditTackState>(
      bloc: BlocProvider.of<AddEditTackBloc>(context),
      builder: (_, AddEditTackState state) {
        final String titleKey;
        final void Function(BuildContext context) onTap;

        if (state.isAdd) {
          titleKey = 'addEditTackScreen.createTackButton';
          onTap = _onCreateTackPressed;
        } else {
          titleKey = 'addEditTackScreen.updateTackButton';
          onTap = _onEditTackPressed;
        }

        return NavigationBarActionButton(
          labelKey: titleKey,
          withFeedback: true,
          type: ButtonType.primary,
          withShadow: true,
          withBorder: true,
          horizontalPadding: 32.0,
          onTap: onTap,
        );
      },
    );
  }

  void _onCreateTackPressed(
    BuildContext context,
  ) {
    BlocProvider.of<AddEditTackBloc>(context).add(const CreateTackRequest());
  }

  void _onEditTackPressed(
    BuildContext context,
  ) {
    BlocProvider.of<AddEditTackBloc>(context).add(const EditTackRequest());
  }
}
