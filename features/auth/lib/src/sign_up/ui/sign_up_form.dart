import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import '../bloc/sign_up_bloc.dart';
import 'widgets/email_section.dart';
import 'widgets/last_name_section.dart';
import 'widgets/passwords_section.dart';
import 'widgets/phone_number_section.dart';
import 'widgets/terms_conditions_resolver.dart';
import 'widgets/first_name_section.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (_, SignUpState state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                FlutterI18n.translate(context, 'signUpScreen.title'),
                style: AppTextTheme.manrope30Bold.copyWith(
                  color: AppTheme.textPrimaryColor,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Expanded(
              child: AppScrollView(
                padding: const EdgeInsets.all(16),
                children: <Widget>[
                  FirstNameSection(state: state),
                  const SizedBox(height: 12),
                  LastNameSection(state: state),
                  const SizedBox(height: 12),
                  EmailSection(state: state),
                  const SizedBox(height: 12),
                  PhoneNumberSection(state: state),
                  const SizedBox(height: 12),
                  PasswordsSection(state: state),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TermsConditionsResolver(state: state),
            ),
            const SizedBox(height: 8),
            KeyboardVisibilityWidget(
              padding: const EdgeInsets.only(bottom: 10),
              child: AppCircleButton(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                labelKey: 'signUpScreen.nextButton',
                onTap: () => _onSubmitButtonPressed(context),
              ),
            ),
          ],
        );
      },
    );
  }

  void _onSubmitButtonPressed(BuildContext context) {
    BlocProvider.of<SignUpBloc>(context).add(const RegisterUserAction());
  }
}
