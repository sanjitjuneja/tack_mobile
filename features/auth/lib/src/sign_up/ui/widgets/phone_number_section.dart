import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import '../../bloc/sign_up_bloc.dart';

class PhoneNumberSection extends StatelessWidget {
  final SignUpState state;

  const PhoneNumberSection({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      initialText: state.phoneVerificationData.phoneNumber,
      suffix: AppIconsTheme.checkMarkFilled(),
      isReadOnly: true,
      isDisabled: true,
      hasShadow: false,
      keyboardType: TextInputType.visiblePassword,
      backgroundColor: AppTheme.textFieldSecondaryBackgroundColor,
    );
  }
}
