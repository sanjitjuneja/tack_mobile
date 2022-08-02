import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

class ErrorScreen extends StatelessWidget {
  final String titleKey;
  final String descriptionKey;
  final Function onPressed;

  const ErrorScreen({
    required this.titleKey,
    required this.descriptionKey,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: AppNavigationBar(
        backgroundColor: AppTheme.secondaryBackgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: <Widget>[
            Text(
              FlutterI18n.translate(
                context,
                titleKey,
              ),
              style: AppTextTheme.manrope32Bold,
            ),
            const SizedBox(height: 44),
            AppImagesTheme.alertError,
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    FlutterI18n.translate(
                      context,
                      descriptionKey,
                    ),
                    style: AppTextTheme.manrope14Medium.copyWith(
                      color: AppTheme.thirdPartyDescriptionColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 44),
                child: RoundedCustomButton(
                  height: 68,
                  text: 'signIn.buttonSignIn',
                  textStyle: AppTextTheme.manrope20Medium.copyWith(
                    color: AppTheme.positiveColor,
                  ),
                  borderRadius: BorderRadius.circular(35),
                  backgroundColor: AppTheme.buttonPrimaryColor,
                  onPressed: () => onPressed(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
