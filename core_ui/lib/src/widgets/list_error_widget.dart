import 'package:core_ui/src/widgets/password_error_tile_widget.dart';
import 'package:domain/models/password_validator.dart';
import 'package:flutter/material.dart';

class ListErrorWidget extends StatelessWidget {
  final bool isPasswordMatch;
  final PasswordValidator errors;

  const ListErrorWidget({
    required this.errors,
    this.isPasswordMatch = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 0),
        children: <Widget>[
          Visibility(
            visible: !isPasswordMatch,
            child: Column(
              children: <Widget>[
                PasswordErrorTileWidget(
                  errorTextKey: 'passwordValidations.length.title',
                  descriptionKey: 'passwordValidations.length.description',
                  isPassed: errors.isLengthValid,
                  isValidationStarted: errors.isValidationStarted,
                ),
                PasswordErrorTileWidget(
                  errorTextKey: 'passwordValidations.capitalLetter.title',
                  descriptionKey:
                      'passwordValidations.capitalLetter.description',
                  isPassed: errors.isContainCapital,
                  isValidationStarted: errors.isValidationStarted,
                ),
                PasswordErrorTileWidget(
                  errorTextKey: 'passwordValidations.number.title',
                  descriptionKey: 'passwordValidations.number.description',
                  isPassed: errors.isContainNumeric,
                  isValidationStarted: errors.isValidationStarted,
                ),
              ],
            ),
          ),
          Visibility(
            visible: isPasswordMatch,
            child: PasswordErrorTileWidget(
              errorTextKey: 'passwordValidations.passwordMatch.title',
              isPassed: errors.isPasswordsMatch,
              isValidationStarted: errors.isValidationStarted,
            ),
          ),
        ],
      ),
    );
  }
}
