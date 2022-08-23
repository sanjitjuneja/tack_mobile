import 'package:auth/src/sign_up/models/email_data.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import '../../bloc/sign_up_bloc.dart';

class EmailSection extends StatelessWidget {
  final SignUpState state;

  const EmailSection({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      placeholder: 'signUpScreen.emailPlaceholder',
      hasShadow: false,
      isInvalid: state.emailData.isInvalid,
      errorTextKey: state.emailData.errorKey,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      backgroundColor: AppTheme.textFieldSecondaryBackgroundColor,
      onTextChange: (String value) => _onEmailChanged(context, value),
    );
  }

  void _onEmailChanged(
    BuildContext context,
    String value,
  ) {
    BlocProvider.of<SignUpBloc>(context).add(EmailChanged(email: value));
  }
}
