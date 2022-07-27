import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:phone_verification/phone_verification/bloc/phone_verification_state.dart';

import 'bloc/phone_verification_bloc.dart';
import 'bloc/phone_verification_event.dart';

class PhoneVerificationScreen extends StatefulWidget {
  final PhoneVerificationType phoneVerificationType;

  const PhoneVerificationScreen({
    required this.phoneVerificationType,
    Key? key,
  }) : super(key: key);

  @override
  State<PhoneVerificationScreen> createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhoneVerificationBloc, PhoneVerificationState>(
      builder: (BuildContext context, PhoneVerificationState state) {
        if (state is PhoneVerificationContent) {
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
                      style: AppTextTheme.manrope16Regular.copyWith(
                        color: AppTheme.textPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.phoneVerificationType ==
                                PhoneVerificationType.signUp
                            ? FlutterI18n.translate(
                                context,
                                'signUp.title',
                              )
                            : FlutterI18n.translate(
                                context,
                                'signIn.forgotPassword',
                              ),
                        style: AppTextTheme.manrope32Bold.copyWith(
                          color: AppTheme.accentColor,
                        ),
                      ),
                      const SizedBox(height: 80),
                      PhoneVerificationWidget(
                        numberController: numberController,
                        onChanged: (String value) {
                          BlocProvider.of<PhoneVerificationBloc>(context).add(
                            UpdateData(
                              phoneNumber: numberController.text,
                            ),
                          );
                        },
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: RoundedCustomButton(
                          height: 60,
                          isEnabled: state.isDataValid,
                          disabledTextStyle:
                              AppTextTheme.manrope20Medium.copyWith(
                            color: AppTheme.accentColor,
                          ),
                          textStyle: AppTextTheme.manrope20Medium.copyWith(
                            color: AppTheme.positiveColor,
                          ),
                          text: 'signUp.primaryButton',
                          backgroundColor: AppTheme.grassColor,
                          disabledText: 'signUp.secondaryButton',
                          disabledBackgroundColor: AppTheme.buttonDisabledColor,
                          borderRadius: BorderRadius.circular(35),
                          onPressed: () {
                            BlocProvider.of<PhoneVerificationBloc>(context).add(
                              VerifyPhoneNumber(
                                phoneNumber: numberController.text,
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
