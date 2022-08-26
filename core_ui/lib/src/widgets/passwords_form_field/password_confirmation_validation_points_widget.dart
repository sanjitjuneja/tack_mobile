part of passwords_form_field;

class PasswordConfirmationValidationPointsWidget extends StatelessWidget {
  final PasswordValidator passwordValidator;

  const PasswordConfirmationValidationPointsWidget({
    super.key,
    required this.passwordValidator,
  });

  @override
  Widget build(BuildContext context) {
    return ValidationPointListWidget(
      children: <ValidationPointWidget>[
        ValidationPointWidget(
          isValidationStarted: passwordValidator.isValidationStarted,
          isValidationPassed: passwordValidator.isPasswordsMatch,
          descriptionKey: 'passwordValidations.passwordMatch.description',
        ),
      ],
    );
  }
}
