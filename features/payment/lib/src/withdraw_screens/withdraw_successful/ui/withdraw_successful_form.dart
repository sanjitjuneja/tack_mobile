import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/use_case.dart';
import 'package:domain/user/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

class WithdrawSuccessfulForm extends StatelessWidget {
  final ObserveUserBalanceUseCase observeUserBalanceUseCase;

  const WithdrawSuccessfulForm({
    Key? key,
    required this.observeUserBalanceUseCase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 10),
        const Spacer(),
        Expanded(
          flex: 5,
          child: Center(
            child: Column(
              children: <Widget>[
                AppIconsTheme.bankRoundedFilled.call(size: 108),
                const SizedBox(height: 30),
                Text(
                  FlutterI18n.translate(
                    context,
                    'withdrawSuccessfulScreen.regularPayoutTitle',
                  ),
                  textAlign: TextAlign.center,
                  style: AppTextTheme.manrope24SemiBold,
                ),
                const SizedBox(height: 30),
                Text(
                  FlutterI18n.translate(
                    context,
                    'withdrawSuccessfulScreen.regularPayoutSubtitle',
                  ),
                  style: AppTextTheme.manrope14Medium.copyWith(
                    color: AppTheme.textDescriptionColor,
                  ),
                ),
                const SizedBox(height: 36),
                StreamBuilder(
                  stream: observeUserBalanceUseCase.execute(NoParams()),
                  builder: (_, AsyncSnapshot<UserBankAccount> snapshot) {
                    return Text(
                      FlutterI18n.translate(
                        context,
                        'withdrawSuccessfulScreen.newTackBalance',
                        translationParams: {
                          'amount': CurrencyUtility.dollarFormat.format(
                            snapshot.data?.usdBalance ?? 0.0,
                          ),
                        },
                      ),
                      style: AppTextTheme.manrope20Bold.copyWith(
                        color: AppTheme.grassColor,
                      ),
                    );
                  },
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
                labelKey: 'withdrawSuccessfulScreen.close',
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
