import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import '../../bloc/sms_verification_bloc.dart';

class ResendCodeWidget extends StatelessWidget {
  final SmsVerificationState state;

  const ResendCodeWidget({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          OpacityOnTapContainer(
            onTap: () => _onResendCodeButtonPressed(context),
            disable: !state.canResendCode,
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
          if (!state.canResendCode) ...<Widget>[
            const SizedBox(width: 6),
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 84),
              child: TimeLeftWidget(
                tillTime: state.nextCodeResendAvailableTime!,
                onExpire: _onResendCodeTimerExpired,
                builder: (_, String content) {
                  return Text(
                    FlutterI18n.translate(
                      context,
                      'smsVerificationScreen.availableIn',
                      translationParams: <String, String>{
                        'time': content,
                      },
                    ),
                    style: AppTextTheme.manrope19Medium.copyWith(
                      color: AppTheme.textHeavyHintColor.withOpacity(0.7),
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _onResendCodeButtonPressed(BuildContext context) {
    BlocProvider.of<SmsVerificationBloc>(context).add(
      const ResendCodeAction(),
    );
  }

  void _onResendCodeTimerExpired(BuildContext context) {
    BlocProvider.of<SmsVerificationBloc>(context).add(
      const ResendCodeTimerExpired(),
    );
  }
}
