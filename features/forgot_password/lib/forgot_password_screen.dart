import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:forgot_password/bloc/forgot_password_event.dart';
import 'package:forgot_password/bloc/forgot_password_state.dart';
import 'package:navigation/navigation.dart';

import 'bloc/forgot_password_bloc.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String password = '';
  String confirmedPassword = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      builder: (BuildContext context, ForgotPasswordState state) {
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: CupertinoScrollbar(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            FlutterI18n.translate(
                                context, 'forgotPassword.title'),
                            style: AppTextTheme.manrope32Bold.copyWith(
                              color: AppTheme.accentColor,
                            ),
                          ),
                          const SizedBox(height: 52),
                          AppTextFormField(
                            obscureText: true,
                            showObscureButton: true,
                            hintText: FlutterI18n.translate(
                              context,
                              'forgotPassword.newPassword',
                            ),
                            onChanged: (String value) {
                              setState(() {
                                password = value;
                              });
                              BlocProvider.of<ForgotPasswordBloc>(context).add(
                                ValidatePassword(password: value),
                              );
                            },
                            errorText: state.postValidationErrors?['password'],
                          ),
                          if (state.passwordErrors != null) ...<Widget>{
                            ListErrorWidget(errors: state.passwordErrors!),
                          },
                          const SizedBox(height: 12),
                          AppTextFormField(
                            obscureText: true,
                            showObscureButton: true,
                            hintText: FlutterI18n.translate(
                              context,
                              'forgotPassword.confirmPassword',
                            ),
                            onChanged: (String value) {
                              setState(() {
                                confirmedPassword = value;
                              });
                              BlocProvider.of<ForgotPasswordBloc>(context).add(
                                ValidateConfirmedPassword(password: value),
                              );
                            },
                            errorText: state
                                .postValidationErrors?['confirmedPassword'],
                          ),
                          if (state.confirmedPasswordErrors !=
                              null) ...<Widget>{
                            ListErrorWidget(
                                errors: state.confirmedPasswordErrors!),
                          },
                        ],
                      ),
                    ),
                  ),
                ),
                KeyboardVisibilityWidget(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: RoundedCustomButton(
                    height: 60,
                    isEnabled: state.isValidationsPassed,
                    borderRadius: BorderRadius.circular(35),
                    text: 'forgotPassword.primaryButton',
                    backgroundColor: AppTheme.grassColor,
                    textStyle: AppTextTheme.manrope20Medium.copyWith(
                      color: AppTheme.positiveColor,
                    ),
                    disabledBackgroundColor: AppTheme.buttonDisabledColor,
                    disabledText: 'forgotPassword.secondaryButton',
                    disabledTextStyle: AppTextTheme.manrope20Medium.copyWith(
                      color: AppTheme.accentColor,
                    ),
                    onPressed: () {
                      BlocProvider.of<ForgotPasswordBloc>(context).add(
                        ChangePassword(
                          password: password,
                          confirmedPassword: confirmedPassword,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
