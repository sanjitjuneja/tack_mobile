import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import '../../bloc/account_settings_bloc.dart';

class LastNameSection extends StatelessWidget {
  final AccountSettingsState state;

  const LastNameSection({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      initialText: state.lastNameData.lastName,
      placeholder: 'accountSettingsScreen.lastNamePlaceholder',
      hasShadow: false,
      isInvalid: state.lastNameData.isInvalid,
      errorTextKey: 'validationErrors.fieldRequired',
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.visiblePassword,
      backgroundColor: AppTheme.textFieldSecondaryBackgroundColor,
      onTextChange: (String value) => _onLastNameChanged(context, value),
    );
  }

  void _onLastNameChanged(
    BuildContext context,
    String value,
  ) {
    BlocProvider.of<AccountSettingsBloc>(context).add(
      LastNameChanged(lastName: value),
    );
  }
}
