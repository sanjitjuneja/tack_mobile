import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../../bloc/sign_up_bloc.dart';

class TermsConditionsResolver extends StatelessWidget {
  final SignUpState state;

  const TermsConditionsResolver({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Material(
          type: MaterialType.transparency,
          child: Theme(
            data: ThemeData(unselectedWidgetColor: AppTheme.successColor),
            child: Radio<bool>(
              value: state.termsData.isAccepted,
              groupValue: true,
              toggleable: true,
              activeColor: AppTheme.successColor,
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onChanged: (bool? value) => _onTermsChanged(context, value),
            ),
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: TextWithHighlight(
            textStyle: AppTextTheme.manrope14Medium
                .copyWith(color: AppTheme.textHeavyHintColor),
            linkHighlightColor: AppTheme.textSecondaryColor,
            text: FlutterI18n.translate(
              context,
              'signUpScreen.termsPrivacyAgreement',
              translationParams: <String, String>{
                'TermsOfServiceLink': FlutterI18n.translate(
                  context,
                  'urls.termsAndConditions',
                ),
                'privacyPolicyLink': FlutterI18n.translate(
                  context,
                  'urls.privacyPolicy',
                ),
                'dwollaTermsOfServiceLink': FlutterI18n.translate(
                  context,
                  'urls.dwollaTermsOfService',
                ),
                'dwollaPrivacyPolicyLink': FlutterI18n.translate(
                  context,
                  'urls.dwollaPrivacyPolicy',
                ),
              },
            ),
            onLinkTap: (String? url) => UrlManager.openUrl(context, url),
          ),
        ),
      ],
    );
  }

  void _onTermsChanged(BuildContext context, bool? value) {
    final bool realValue = value != null ? !value : false;

    BlocProvider.of<SignUpBloc>(context).add(
      TermsAndConditionsChanged(isAccepted: realValue),
    );
  }
}
