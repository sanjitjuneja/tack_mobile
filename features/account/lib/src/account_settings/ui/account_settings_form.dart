import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import '../bloc/account_settings_bloc.dart';
import 'widgets/email_section.dart';
import 'widgets/first_name_section.dart';
import 'widgets/last_name_section.dart';

class AccountSettingsForm extends StatelessWidget {
  const AccountSettingsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountSettingsBloc, AccountSettingsState>(
      builder: (_, AccountSettingsState state) {
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                FlutterI18n.translate(context, 'accountInfoScreen.title'),
                textAlign: TextAlign.center,
                style: AppTextTheme.manrope32Bold.copyWith(
                  color: AppTheme.accentColor,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: AppScrollView(
                children: <Widget>[
                  FirstNameSection(state: state),
                  const SizedBox(height: 12),
                  LastNameSection(state: state),
                  const SizedBox(height: 12),
                  EmailSection(state: state),
                ],
              ),
            ),
            const SizedBox(height: 6),
            KeyboardVisibilityWidget(
              padding: const EdgeInsets.only(bottom: 10),
              child: AppCircleButton(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                labelKey: 'accountSettingsScreen.saveChangesButton',
                onTap: () => _onSubmitButtonPressed(context),
              ),
            ),
          ],
        );
      },
    );
  }

  void _onSubmitButtonPressed(BuildContext context) {
    BlocProvider.of<AccountSettingsBloc>(context).add(
      const UpdateProfileAction(),
    );
  }
}
