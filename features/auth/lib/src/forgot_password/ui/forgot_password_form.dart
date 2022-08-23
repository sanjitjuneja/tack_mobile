import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import '../bloc/forgot_password_bloc.dart';

class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      builder: (_, ForgotPasswordState state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 10),
              Text(
                FlutterI18n.translate(context, 'forgotPasswordScreen.title'),
                style: AppTextTheme.manrope30Bold.copyWith(
                  color: AppTheme.textPrimaryColor,
                ),
              ),
              const Spacer(flex: 1),
              AppScrollView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  PasswordsFormField(
                    passwordPlaceholderKey:
                        'forgotPasswordScreen.newPasswordPlaceholder',
                    passwordConfirmationPlaceholderKey:
                        'forgotPasswordScreen.confirmPasswordPlaceholder',
                    passwordValidator: state.passwordsValidator,
                    passwordData: state.passwordData,
                    confirmationPasswordData: state.passwordConfirmationData,
                    onPasswordChanged: _onPasswordChanged,
                    onPasswordConfirmationChanged:
                        _onPasswordConfirmationChanged,
                  ),
                ],
              ),
              const Spacer(flex: 4),
              AppCircleButton(
                labelKey: 'forgotPasswordScreen.submitButton',
                onTap: () => _onSubmitButtonPressed(context),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  void _onPasswordChanged(
    BuildContext context,
    String data,
  ) {
    BlocProvider.of<ForgotPasswordBloc>(context).add(
      PasswordChanged(password: data),
    );
  }

  void _onPasswordConfirmationChanged(
    BuildContext context,
    String data,
  ) {
    BlocProvider.of<ForgotPasswordBloc>(context).add(
      PasswordConfirmationChanged(password: data),
    );
  }

  void _onSubmitButtonPressed(BuildContext context) {
    BlocProvider.of<ForgotPasswordBloc>(context)
        .add(const SubmitNewPasswordAction());
  }
}
