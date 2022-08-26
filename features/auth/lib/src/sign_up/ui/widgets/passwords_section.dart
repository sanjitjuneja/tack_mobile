import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import '../../bloc/sign_up_bloc.dart';

class PasswordsSection extends StatelessWidget {
  final SignUpState state;

  const PasswordsSection({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return PasswordsFormField(
      passwordPlaceholderKey: 'signUpScreen.newPasswordPlaceholder',
      passwordConfirmationPlaceholderKey:
          'signUpScreen.confirmPasswordPlaceholder',
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
    BlocProvider.of<SignUpBloc>(context).add(
      PasswordChanged(password: data),
    );
  }

  void _onPasswordConfirmationChanged(
    BuildContext context,
    String data,
  ) {
    BlocProvider.of<SignUpBloc>(context).add(
      PasswordConfirmationChanged(password: data),
    );
  }
}
