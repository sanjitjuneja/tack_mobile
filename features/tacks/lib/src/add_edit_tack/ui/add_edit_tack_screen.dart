import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import 'package:tacks/src/add_edit_tack/bloc/add_edit_tack_bloc.dart';
import 'package:tacks/src/add_edit_tack/ui/add_edit_tack_form.dart';

class AddEditTackScreen extends StatelessWidget {
  const AddEditTackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.secondaryBackgroundColor,
      navigationBar: AppNavigationBar(
        backgroundColor: AppTheme.secondaryBackgroundColor,
        withResult: true,
        actions: <Widget>[
          BlocBuilder<AddEditTackBloc, AddEditTackState>(
            bloc: BlocProvider.of<AddEditTackBloc>(context),
            builder: (_, AddEditTackState state) {
              if (state.isAdd) {
                return NavigationBarActionButton(
                  labelKey: 'addEditTackScreen.clearButton',
                  horizontalPadding: 32.0,
                  isDisabled: !state.isAnyDataChanged,
                  onTap: _onClearButtonPressed,
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
      child: const SafeArea(
        child: KeyboardDismissible(
          child: AddEditTackForm(),
        ),
      ),
    );
  }

  void _onClearButtonPressed(BuildContext context) {
    BlocProvider.of<AddEditTackBloc>(context).add(const ClearAction());
  }
}
