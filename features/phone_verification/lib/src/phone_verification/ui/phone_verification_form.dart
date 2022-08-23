import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import '../bloc/phone_verification_bloc.dart';
import 'widgets/phone_verification_text_field.dart';

class PhoneVerificationForm extends StatelessWidget {
  const PhoneVerificationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhoneVerificationBloc, PhoneVerificationState>(
      builder: (_, PhoneVerificationState state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                FlutterI18n.translate(
                  context,
                  'phoneVerificationScreen.title',
                ),
                style: AppTextTheme.manrope32Bold.copyWith(
                  color: AppTheme.textPrimaryColor,
                ),
              ),
              const SizedBox(height: 80),
              PhoneVerificationTextField(state: state),
              const Spacer(),
              AppCircleButton(
                labelKey: 'phoneVerificationScreen.verifyButton',
                isDisabled: !state.isReadyToProceed,
                onTap: () => _onVerifyButtonPressed(context),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  void _onVerifyButtonPressed(BuildContext context) {
    BlocProvider.of<PhoneVerificationBloc>(context).add(const VerifyAction());
  }
}
