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

class _NumberVerifyScreenState extends State<NumberVerifyScreen> {
  final TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SmsVerificationBloc, SmsVerificationState>(
      builder: (BuildContext context, SmsVerificationState state) {
        if (state is SmsVerificationContent) {
          return CupertinoPageScaffold(
            backgroundColor: AppTheme.positiveColor,
            navigationBar: CupertinoNavigationBar(
              border: null,
              backgroundColor: AppTheme.primaryColor,
              leading: CupertinoButton(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                onPressed: () => AppRouter.of(context).popWithResult(null),
                child: Row(
                  children: [
                    AppImagesTheme.backArrow,
                    const SizedBox(width: 16),
                    Text(
                      FlutterI18n.translate(context, 'general.back'),
                      style: AppTextTheme.manrope16Light.copyWith(
                        color: AppTheme.textPrimaryColor,
                      ),
                    ),
                  ],
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
                        FlutterI18n.translate(context, 'smsVerification.title'),
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
                              TextSpan(
                                text: FlutterI18n.translate(
                                  context,
                                  'smsVerification.description',
                                ),
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
                          BlocProvider.of<SmsVerificationBloc>(context).add(
                            UpdateData(
                              verificationCode: codeController.text,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 22),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            BlocProvider.of<SmsVerificationBloc>(context).add(
                              RequestVerificationCode(),
                            );
                          },
                          child: Text(
                            FlutterI18n.translate(
                              context,
                              'smsVerification.resendCode',
                            ),
                            style: AppTextTheme.manrope19Medium.copyWith(
                              color: AppTheme.heighlitedColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: RoundedCustomButton(
                          height: 60,
                          isEnabled: state.isDataValid,
                          text: 'smsVerification.buttonPrimary',
                          disabledText: 'smsVerification.buttonSecondary',
                          textStyle: AppTextTheme.manrope20Medium.copyWith(
                            color: AppTheme.positiveColor,
                          ),
                          disabledTextStyle:
                              AppTextTheme.manrope20Medium.copyWith(
                            color: AppTheme.accentColor,
                          ),
                          borderRadius: BorderRadius.circular(35),
                          backgroundColor: AppTheme.grassColor,
                          disabledBackgroundColor: AppTheme.buttonDisabledColor,
                          onPressed: () {
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
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
