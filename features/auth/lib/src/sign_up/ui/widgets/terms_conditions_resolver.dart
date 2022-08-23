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
      crossAxisAlignment: CrossAxisAlignment.center,
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
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onChanged: (bool? value) => _onTermsChanged(context, value),
            ),
          ),
        ),
        Expanded(
          child: TextWithHighlight(
            textStyle: AppTextTheme.manrope14Medium
                .copyWith(color: AppTheme.textHeavyHintColor),
            text: FlutterI18n.translate(
              context,
              'signUpScreen.termsPrivacyAgreement',
              translationParams: <String, String>{
                'termsConditionsLink': FlutterI18n.translate(
                  context,
                  'urls.termsAndConditions',
                ),
                'privacyPolicyLink': FlutterI18n.translate(
                  context,
                  'urls.privacyPolicy',
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
