import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/use_case.dart';
import 'package:domain/user/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

class AddToTackBalanceSuccessfulForm extends StatelessWidget {
  final GetUserBalanceUseCase getUserBalanceUseCase;

  const AddToTackBalanceSuccessfulForm({
    Key? key,
    required this.getUserBalanceUseCase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 10),
        const Spacer(),
        Expanded(
          flex: 3,
          child: Center(
            child: Column(
              children: <Widget>[
                AppIconsTheme.checkmark.call(size: 108),
                const SizedBox(height: 30),
                Text(
                  FlutterI18n.translate(
                    context,
                    'addToTackBalanceSuccessfulScreen.depositComplete',
                  ),
                  textAlign: TextAlign.center,
                  style: AppTextTheme.manrope24SemiBold,
                ),
                const SizedBox(height: 30),
                Text(
                  FlutterI18n.translate(
                    context,
                    'addToTackBalanceSuccessfulScreen.newTackBalance',
                    translationParams: {
                      'amount': CurrencyUtility.dollarFormat.format(
                        getUserBalanceUseCase.execute(NoParams()).usdBalance,
                      ),
                    },
                  ),
                  style: AppTextTheme.manrope20Bold.copyWith(
                    color: AppTheme.grassColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
        Row(
          children: <Widget>[
            const Spacer(),
            Expanded(
              flex: 4,
              child: AppCircleButton(
                labelKey: 'addToTackBalanceSuccessfulScreen.close',
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
