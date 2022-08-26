import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import '../bloc/sms_verification_bloc.dart';
import '../view_extensions/phone_verification_to_view_sms_extension.dart';
import 'widgets/verify_code_field_widget.dart';

class SmsVerificationForm extends StatelessWidget {
  const SmsVerificationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SmsVerificationBloc, SmsVerificationState>(
      builder: (_, SmsVerificationState state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                state.phoneVerificationData.getTitle(context),
                style: AppTextTheme.manrope32Bold.copyWith(
                  color: AppTheme.textPrimaryColor,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(right: 14),
                child: TextWithHighlight(
                  text: state.phoneVerificationData.getDescription(context),
                  textStyle: AppTextTheme.manrope18Regular
                      .copyWith(color: AppTheme.textPrimaryColor),
                ),
              ),
              const SizedBox(height: 22),
              const VerifyCodeFieldWidget(),
              const SizedBox(height: 22),
              Center(
                child: OpacityOnTapContainer(
                  onTap: () => _onResendCodeButtonPressed(context),
                  child: Text(
                    FlutterI18n.translate(
                      context,
                      'smsVerificationScreen.resendCode',
                    ),
                    style: AppTextTheme.manrope19Medium.copyWith(
                      color: AppTheme.textHeavyHintColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              AppCircleButton(
                labelKey: state.phoneVerificationData.getButtonLabel(context),
                isDisabled: !state.isReadyToProceed,
                onTap: () => _onNextButtonPressed(context),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  void _onResendCodeButtonPressed(BuildContext context) {
    BlocProvider.of<SmsVerificationBloc>(context).add(const ResendCodeAction());
  }

  void _onNextButtonPressed(BuildContext context) {
    BlocProvider.of<SmsVerificationBloc>(context).add(
      const VerifyNumberAction(),
    );
  }
}
