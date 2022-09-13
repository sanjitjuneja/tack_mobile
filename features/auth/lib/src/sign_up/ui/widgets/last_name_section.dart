import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import '../../bloc/sign_up_bloc.dart';

class LastNameSection extends StatelessWidget {
  final SignUpState state;

  const LastNameSection({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      placeholder: 'signUpScreen.lastNamePlaceholder',
      hasShadow: false,
      isInvalid: state.lastNameData.isInvalid,
      errorTextKey: 'validationErrors.fieldRequired',
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.visiblePassword,
      backgroundColor: AppTheme.textFieldSecondaryBackgroundColor,
      onTextChange: (String value) => _onLastNameChanged(context, value),
    );
  }

  void _onLastNameChanged(
    BuildContext context,
    String value,
  ) {
    BlocProvider.of<SignUpBloc>(context).add(LastNameChanged(lastName: value));
  }
}
