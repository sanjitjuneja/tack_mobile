import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import '../../bloc/change_password_bloc.dart';

class OldPasswordSection extends StatelessWidget {
  final ChangePasswordState state;

  const OldPasswordSection({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final bool isNewAndOldIdentical =
        state.oldPasswordData.isValidationEnabled &&
            state.passwordsValidator.isNewAndOldIdentical;

    return AppTextField(
      placeholder: 'changePasswordScreen.currentPasswordPlaceholder',
      shouldObscure: true,
      hasShadow: false,
      isInvalid: isNewAndOldIdentical || state.oldPasswordData.isInvalid,
      errorTextKey:
          isNewAndOldIdentical ? null : state.oldPasswordData.errorKey,
      scrollPadding: 80,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.visiblePassword,
      backgroundColor: AppTheme.textFieldSecondaryBackgroundColor,
      onTextChange: (String value) => _onOldPasswordChanged(context, value),
    );
  }

  void _onOldPasswordChanged(
    BuildContext context,
    String data,
  ) {
    BlocProvider.of<ChangePasswordBloc>(context).add(
      OldPasswordChanged(password: data),
    );
  }
}
