part of passwords_form_field;

class PasswordValidationPointsWidget extends StatelessWidget {
  final PasswordValidator passwordValidator;

  const PasswordValidationPointsWidget({
    super.key,
    required this.passwordValidator,
  });

  @override
  Widget build(BuildContext context) {
    return ValidationPointListWidget(
      children: <ValidationPointWidget>[
        ValidationPointWidget(
          isValidationStarted: passwordValidator.isValidationStarted,
          isValidationPassed: passwordValidator.isLengthValid,
          descriptionKey: 'passwordValidations.length.description',
          exampleKey: 'passwordValidations.length.example',
        ),
        ValidationPointWidget(
          isValidationStarted: passwordValidator.isValidationStarted,
          isValidationPassed: passwordValidator.isContainCapital,
          descriptionKey: 'passwordValidations.capitalLetter.description',
          exampleKey: 'passwordValidations.capitalLetter.example',
        ),
        ValidationPointWidget(
          isValidationStarted: passwordValidator.isValidationStarted,
          isValidationPassed: passwordValidator.isContainNumeric,
          descriptionKey: 'passwordValidations.number.description',
          exampleKey: 'passwordValidations.number.example',
        ),
      ],
    );
  }
}
