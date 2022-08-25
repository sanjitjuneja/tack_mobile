import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import '../../bloc/change_password_bloc.dart';

class NewPasswordSection extends StatelessWidget {
  final ChangePasswordState state;

  const NewPasswordSection({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return PasswordsFormField(
      passwordPlaceholderKey: 'changePasswordScreen.newPasswordPlaceholder',
      passwordConfirmationPlaceholderKey:
          'changePasswordScreen.confirmPasswordPlaceholder',
      passwordsValidator: state.passwordsValidator,
      passwordData: state.passwordData,
      confirmationPasswordData: state.passwordConfirmationData,
      onPasswordChanged: _onPasswordChanged,
      onPasswordConfirmationChanged: _onPasswordConfirmationChanged,
    );
  }

  void _onPasswordChanged(
    BuildContext context,
    String data,
  ) {
    BlocProvider.of<ChangePasswordBloc>(context).add(
      PasswordChanged(password: data),
    );
  }

  void _onPasswordConfirmationChanged(
    BuildContext context,
    String data,
  ) {
    BlocProvider.of<ChangePasswordBloc>(context).add(
      PasswordConfirmationChanged(password: data),
    );
  }
}
