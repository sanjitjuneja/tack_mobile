import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import '../../bloc/phone_verification_bloc.dart';

class PhoneVerificationTextField extends StatelessWidget {
  final PhoneVerificationState state;

  const PhoneVerificationTextField({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      autoFocus: true,
      shouldShowOverlayIfNeeded: false,
      padding: const EdgeInsets.only(
        left: 12,
        top: 24,
        bottom: 24,
        right: 16,
      ),
      prefix: Row(
        children: <Widget>[
          const SizedBox(width: 14),
          AppImagesTheme.americanFlag,
          const SizedBox(width: 8),
          Text(
            Constants.kPhonePrefix,
            style: AppTextTheme.manrope16Medium.copyWith(
              color: AppTheme.accentColor,
            ),
          ),
          const SizedBox(width: 30),
          AppDivider(
            axis: Axis.vertical,
            height: 38,
            color: AppTheme.dividerSecondaryColor,
          ),
        ],
      ),
      initialText: state.phoneData.phone,
      hasShadow: false,
      keyboardType: TextInputType.number,
      backgroundColor: AppTheme.textFieldSecondaryBackgroundColor,
      inputFormatters: PhoneNumberFormatter.phoneInputFormatters,
      textStyle: AppTextTheme.manrope22Medium.copyWith(
        color: AppTheme.accentColor,
        letterSpacing: 3,
      ),
      onTextChange: (String value) => _onPhoneNumberChanged(context, value),
    );
  }

  void _onPhoneNumberChanged(BuildContext context, String phoneNumber) {
    BlocProvider.of<PhoneVerificationBloc>(context).add(
      PhoneNumberChanged(phoneNumber),
    );
  }
}
