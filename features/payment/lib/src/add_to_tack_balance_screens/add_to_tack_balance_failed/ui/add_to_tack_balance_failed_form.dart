import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

class AddToTackBalanceFailedForm extends StatelessWidget {
  final String errorKey;

  const AddToTackBalanceFailedForm({
    Key? key,
    required this.errorKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 10),
        const Spacer(),
        Expanded(
          flex: 8,
          child: Center(
            child: Column(
              children: <Widget>[
                Center(
                  child: Text(
                    FlutterI18n.translate(
                      context,
                      'addToTackBalanceFailedScreen.title',
                    ),
                    style: AppTextTheme.manrope32Bold,
                  ),
                ),
                const Spacer(),
                AppIconsTheme.redCrossRounded.call(size: 120),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 49),
                  child: Text(
                    FlutterI18n.translate(
                      context,
                      errorKey,
                    ),
                    textAlign: TextAlign.center,
                    style: AppTextTheme.manrope14Medium.copyWith(
                      color: AppTheme.textHeavyHintColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Spacer(flex: 4),
        Row(
          children: <Widget>[
            const Spacer(),
            Expanded(
              flex: 4,
              child: AppCircleButton(
                labelKey: 'addToTackBalanceFailedScreen.close',
                expanded: false,
                onTap: () => _onClosePress(context),
              ),
            ),
            const Spacer(),
          ],
        ),
        const Spacer(),
        const SizedBox(height: 10),
      ],
    );
  }

  void _onClosePress(BuildContext context) => AppRouter.of(context).pop();
}
