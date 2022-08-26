import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import '../bloc/sign_in_bloc.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (_, SignInState state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                FlutterI18n.translate(context, 'signInScreen.title'),
                style: AppTextTheme.manrope32Bold.copyWith(
                  color: AppTheme.textPrimaryColor,
                ),
              ),
              const SizedBox(height: 21),
              AppTextField(
                placeholder: 'signInScreen.loginPlaceholder',
                hasShadow: false,
                isInvalid: state.loginData.isInvalid || state.wrongCredentials,
                errorTextKey: state.loginData.isInvalid
                    ? 'validationErrors.invalidLogin'
                    : null,
                backgroundColor: AppTheme.textFieldSecondaryBackgroundColor,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                onTextChange: (String value) => _onLoginChanged(context, value),
              ),
              const SizedBox(height: 14),
              AppTextField(
                placeholder: 'signInScreen.passwordPlaceholder',
                shouldObscure: true,
                hasShadow: false,
                isInvalid:
                    state.passwordData.isInvalid || state.wrongCredentials,
                errorTextKey: state.passwordData.isInvalid
                    ? 'validationErrors.fieldRequired'
                    : 'validationErrors.wrongCredentials',
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.visiblePassword,
                backgroundColor: AppTheme.textFieldSecondaryBackgroundColor,
                onTextChange: (String value) =>
                    _onPasswordChanged(context, value),
              ),
              const SizedBox(height: 14),
              Align(
                alignment: Alignment.centerRight,
                child: OpacityOnTapContainer(
                  onTap: () => _onForgotPasswordButtonPressed(context),
                  child: Text(
                    FlutterI18n.translate(
                      context,
                      'signInScreen.forgotPassword',
                    ),
                    style: AppTextTheme.manrope14Medium.copyWith(
                      color: AppTheme.textHeavyHintColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              AppCircleButton(
                labelKey: 'signInScreen.signInButton',
                onTap: () => _onSignInButtonPressed(context),
              ),
              const SizedBox(height: 8),
              const Spacer(),
              KeyboardVisibilityWidget(
                padding: const EdgeInsets.only(bottom: 10),
                child: OpacityOnTapContainer(
                  onTap: () => _onSignUpButtonPressed(context),
                  child: TextWithHighlight(
                    text: FlutterI18n.translate(
                      context,
                      'signInScreen.notRegisteredYet',
                    ),
                    textStyle: AppTextTheme.manrope14Bold
                        .copyWith(color: AppTheme.textHeavyHintColor),
                    textAlign: TextAlign.center,
                    coloredTextColor: AppTheme.textSecondaryColor,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onLoginChanged(
    BuildContext context,
    String login,
  ) {
    BlocProvider.of<SignInBloc>(context).add(LoginChanged(login));
  }

  void _onPasswordChanged(
    BuildContext context,
    String password,
  ) {
    BlocProvider.of<SignInBloc>(context).add(PasswordChanged(password));
  }

  void _onSignInButtonPressed(BuildContext context) {
    BlocProvider.of<SignInBloc>(context).add(const SignInAction());
  }

  void _onForgotPasswordButtonPressed(BuildContext context) {
    BlocProvider.of<SignInBloc>(context).add(const ForgotPasswordAction());
  }

  void _onSignUpButtonPressed(BuildContext context) {
    BlocProvider.of<SignInBloc>(context).add(const SignUpAction());
  }
}
