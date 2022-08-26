import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import '../bloc/change_password_bloc.dart';
import 'widgets/new_password_section.dart';
import 'widgets/old_password_section.dart';

class ChangePasswordForm extends StatelessWidget {
  const ChangePasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      builder: (_, ChangePasswordState state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                FlutterI18n.translate(context, 'changePasswordScreen.title'),
                style: AppTextTheme.manrope30Bold.copyWith(
                  color: AppTheme.textPrimaryColor,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: AppScrollView(
                children: <Widget>[
                  OldPasswordSection(state: state),
                  const SizedBox(height: 24),
                  NewPasswordSection(state: state),
                ],
              ),
            ),
            KeyboardVisibilityWidget(
              padding: const EdgeInsets.only(bottom: 10),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: AppCircleButton(
                  labelKey: 'changePasswordScreen.setPasswordButton',
                  onTap: () => _onSubmitButtonPressed(context),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _onSubmitButtonPressed(BuildContext context) {
    BlocProvider.of<ChangePasswordBloc>(context).add(
      const SubmitNewPasswordAction(),
    );
  }
}
