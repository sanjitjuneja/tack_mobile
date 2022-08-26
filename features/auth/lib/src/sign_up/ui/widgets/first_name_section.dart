import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import '../../bloc/sign_up_bloc.dart';

class FirstNameSection extends StatelessWidget {
  final SignUpState state;

  const FirstNameSection({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      placeholder: 'signUpScreen.firstNamePlaceholder',
      hasShadow: false,
      isInvalid: state.firstNameData.isInvalid,
      errorTextKey: 'validationErrors.fieldRequired',
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.visiblePassword,
      backgroundColor: AppTheme.textFieldSecondaryBackgroundColor,
      onTextChange: (String value) => _onFirstNameChanged(context, value),
    );
  }

  void _onFirstNameChanged(
    BuildContext context,
    String value,
  ) {
    BlocProvider.of<SignUpBloc>(context).add(
      FirstNameChanged(firstName: value),
    );
  }
}
