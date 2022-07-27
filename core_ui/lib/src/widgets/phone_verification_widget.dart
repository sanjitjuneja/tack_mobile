import 'package:core/constants/constants.dart';
import 'package:flutter/material.dart';

import '../../core_ui.dart';

class PhoneVerificationWidget extends StatelessWidget {
  final Function(String) onChanged;
  final TextEditingController numberController;

  const PhoneVerificationWidget({
    required this.onChanged,
    required this.numberController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      decoration: BoxDecoration(
        color: AppTheme.textFieldBackgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
        child: Row(
          children: [
            Row(
              children: [
                AppImagesTheme.americanFlag,
                Text(
                  Constants.kPhonePrefix,
                  style: AppTextTheme.manrope16Medium.copyWith(
                    color: AppTheme.accentColor,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                top: 15,
                bottom: 15,
              ),
              child: VerticalDivider(
                thickness: 1.5,
                width: 35,
                color: AppTheme.textFieldDividerColor,
              ),
            ),
            Flexible(
              child: PhoneNumberTextField(
                controller: numberController,
                onChanged: (String value) {
                  onChanged(value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
