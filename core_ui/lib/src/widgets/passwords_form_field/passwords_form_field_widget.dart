part of passwords_form_field;

class PasswordsFormField extends StatelessWidget {
  final String passwordPlaceholderKey;
  final String passwordConfirmationPlaceholderKey;
  final PasswordValidator passwordsValidator;
  final PasswordData passwordData;
  final PasswordConfirmationData confirmationPasswordData;
  final void Function(BuildContext, String) onPasswordChanged;
  final void Function(BuildContext, String) onPasswordConfirmationChanged;

  const PasswordsFormField({
    super.key,
    required this.passwordPlaceholderKey,
    required this.passwordConfirmationPlaceholderKey,
    required this.passwordsValidator,
    required this.passwordData,
    required this.confirmationPasswordData,
    required this.onPasswordChanged,
    required this.onPasswordConfirmationChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool isNewAndOldIdentical = passwordData.isValidationEnabled &&
        passwordsValidator.isNewAndOldIdentical;

    return Column(
      children: <Widget>[
        AppTextField(
          placeholder: passwordPlaceholderKey,
          shouldObscure: true,
          hasShadow: false,
          isInvalid: isNewAndOldIdentical || passwordData.isInvalid,
          errorTextKey: isNewAndOldIdentical
              ? 'validationErrors.oldAndNewPasswordsIdentical'
              : 'validationErrors.fieldRequired',
          scrollPadding: 80,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.visiblePassword,
          backgroundColor: AppTheme.textFieldSecondaryBackgroundColor,
          onTextChange: (String value) => onPasswordChanged(context, value),
        ),
        PasswordValidationPointsWidget(
          passwordValidator: passwordsValidator,
        ),
        const SizedBox(height: 10),
        AppTextField(
          placeholder: passwordConfirmationPlaceholderKey,
          shouldObscure: true,
          hasShadow: false,
          isInvalid: confirmationPasswordData.isInvalid,
          errorTextKey: 'validationErrors.fieldRequired',
          scrollPadding: 50,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.visiblePassword,
          backgroundColor: AppTheme.textFieldSecondaryBackgroundColor,
          onTextChange: (String value) =>
              onPasswordConfirmationChanged(context, value),
        ),
        PasswordConfirmationValidationPointsWidget(
          passwordValidator: passwordsValidator,
        ),
      ],
    );
  }
}
