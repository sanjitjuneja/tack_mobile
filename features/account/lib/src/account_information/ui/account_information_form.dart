import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import '../bloc/account_information_bloc.dart';

class AccountInformationForm extends StatelessWidget {
  const AccountInformationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountInformationBloc, AccountInformationState>(
      builder: (_, AccountInformationState state) {
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
                  AppTextField(
                    initialText: state.user.firstName,
                    shouldUpdateInitialText: true,
                    isReadOnly: true,
                    isDisabled: true,
                    hasShadow: false,
                    backgroundColor: AppTheme.textFieldSecondaryBackgroundColor,
                  ),
                  const SizedBox(height: 12),
                  AppTextField(
                    initialText: state.user.lastName,
                    shouldUpdateInitialText: true,
                    isReadOnly: true,
                    isDisabled: true,
                    hasShadow: false,
                    backgroundColor: AppTheme.textFieldSecondaryBackgroundColor,
                  ),
                  const SizedBox(height: 12),
                  AppTextField(
                    initialText: state.user.email,
                    shouldUpdateInitialText: true,
                    isReadOnly: true,
                    isDisabled: true,
                    hasShadow: false,
                    backgroundColor: AppTheme.textFieldSecondaryBackgroundColor,
                  ),
                  const SizedBox(height: 12),
                  AppTextField(
                    initialText: state.user.phoneNumber,
                    suffix: AppIconsTheme.checkMarkFilled(),
                    isReadOnly: true,
                    isDisabled: true,
                    hasShadow: false,
                    backgroundColor: AppTheme.textFieldSecondaryBackgroundColor,
                    inputFormatters:
                        PhoneNumberFormatter.phoneReadOnlyFormatters(
                      state.user.phoneNumber,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: <Widget>[
                  AppCircleButton(
                    labelKey: 'accountInfoScreen.changePasswordButton',
                    backgroundColor: AppTheme.buttonDisabledColor,
                    borderColor: AppTheme.buttonDisabledColor,
                    interfaceColor: AppTheme.textHeavyHintColor,
                    onTap: () => _onChangePasswordButtonPressed(context),
                  ),
                  const SizedBox(height: 20),
                  AppCircleButton(
                    labelKey: 'accountInfoScreen.deleteAccountButton',
                    backgroundColor: AppTheme.buttonDisabledColor,
                    borderColor: AppTheme.buttonDisabledColor,
                    interfaceColor: AppTheme.textHeavyHintColor,
                    onTap: () => _onDeleteAccountButtonPressed(context),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _onChangePasswordButtonPressed(BuildContext context) {
    BlocProvider.of<AccountInformationBloc>(context).add(
      const ChangePasswordAction(),
    );
  }

  void _onDeleteAccountButtonPressed(BuildContext context) {
    BlocProvider.of<AccountInformationBloc>(context).add(
      const DeleteAccountAction(),
    );
  }
}
