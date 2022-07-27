import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../core_ui.dart';

class TermsConditionsResolver extends StatefulWidget {
  final Function(bool) onChanged;

  const TermsConditionsResolver({
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  State<TermsConditionsResolver> createState() =>
      _TermsConditionsResolverState();
}

class _TermsConditionsResolverState extends State<TermsConditionsResolver> {
  bool radioValue = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CustomCheckBox(
          value: radioValue,
          negativeImage: AppImagesTheme.radioCheckBoxFalse,
          positiveImage: AppImagesTheme.radioCheckBoxTrue,
          onChanged: (bool value) {
            setState(() {
              radioValue = !radioValue;
            });
            widget.onChanged(radioValue);
          },
        ),
        const SizedBox(width: 8),
        RichText(
          text: TextSpan(
            style: AppTextTheme.manrope14Medium.copyWith(
              color: AppTheme.heighlitedColor,
            ),
            children: <TextSpan>[
              TextSpan(
                text: FlutterI18n.translate(
                  context,
                  'personalInformation.agreementTitle',
                ),
              ),
              TextSpan(
                text: FlutterI18n.translate(
                  context,
                  'personalInformation.terms',
                ),
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
              TextSpan(
                text: FlutterI18n.translate(
                  context,
                  'general.andSymbol',
                ),
              ),
              TextSpan(
                text: FlutterI18n.translate(
                  context,
                  'personalInformation.privacy',
                ),
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
