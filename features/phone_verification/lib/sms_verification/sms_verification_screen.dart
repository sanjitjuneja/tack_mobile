import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import 'bloc/sms_verification_bloc.dart';
import 'bloc/sms_verification_event.dart';
import 'bloc/sms_verification_state.dart';

class NumberVerifyScreen extends StatefulWidget {
  final String phoneNumber;

  const NumberVerifyScreen({
    required this.phoneNumber,
    Key? key,
  }) : super(key: key);

  @override
  State<NumberVerifyScreen> createState() => _NumberVerifyScreenState();
}

bool isCodeResend = false;
bool isVerifyAvailable = false;

class _NumberVerifyScreenState extends State<NumberVerifyScreen> {
  final TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SmsVerificationBloc, SmsVerificationState>(
      builder: (BuildContext context, state) {
        return CupertinoPageScaffold(
          backgroundColor: AppTheme.positiveColor,
          navigationBar: CupertinoNavigationBar(
            border: null,
            backgroundColor: AppTheme.primaryColor,
            leading: CupertinoButton(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              onPressed: () => AppRouter.of(context).popWithResult(null),
              child: Text(
                FlutterI18n.translate(context, 'general.cancel'),
                style: AppTextTheme.manrope16Light.copyWith(
                  color: AppTheme.textPrimaryColor,
                ),
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SafeArea(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Verify Phone Number',
                      style: AppTextTheme.manrope32Bold.copyWith(
                        color: AppTheme.accentColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: RichText(
                        text: TextSpan(
                          style: AppTextTheme.manrope19SemiBold.copyWith(
                            color: AppTheme.heighlitedColor,
                          ),
                          children: <TextSpan>[
                            const TextSpan(
                              text: 'Please enter the 6-digit code sent to ',
                            ),
                            TextSpan(
                              text: widget.phoneNumber,
                              style: TextStyle(
                                color: AppTheme.accentColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    VerifyCodeField(
                      controller: codeController,
                      onChanged: (String code) {
                        checkIsVerifyAvailable(code);
                      },
                    ),
                    const SizedBox(height: 22),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Resend Code',
                          style: AppTextTheme.manrope19Medium.copyWith(
                            color: AppTheme.heighlitedColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: AppButton(
                        isDisabled: isVerifyAvailable,
                        labelKey: FlutterI18n.translate(
                          context,
                          'phoneVerification.buttonText',
                        ),
                        textStyle: AppTextTheme.manrope20Medium.copyWith(
                          color: AppTheme.positiveColor,
                        ),
                        backgroundColor: AppTheme.grassColor,
                        onTap: () {
                          BlocProvider.of<SmsVerificationBloc>(context).add(
                            VerifyNumber(
                              verificationCode: codeController.text,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void checkIsVerifyAvailable(String verificationCode) {
    if (codeController.text.length == 6) {
      setState(() {
        isVerifyAvailable = true;
      });
    } else {
      setState(() {
        isVerifyAvailable = false;
      });
    }
  }
}
