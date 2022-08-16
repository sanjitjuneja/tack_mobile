import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:payment/src/widgets/tack_button.dart';
import 'package:payment/src/withdraw/withdraw_amount/widgets/withdraw_method_type.dart';
import '../bloc/withdraw_successful_bloc.dart';

class WithdrawSuccessfulForm extends StatelessWidget {
  final WithdrawMethodType withdrawMethodType;

  const WithdrawSuccessfulForm({
    Key? key,
    required this.withdrawMethodType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WithdrawSuccessfulBloc, WithdrawSuccessfulState>(
      builder: (context, state) {
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
                    AppIconsTheme.bankRoundedFilled.call(size: 108),
                    const SizedBox(height: 30),
                    Text(
                      FlutterI18n.translate(
                        context,
                        withdrawMethodType == WithdrawMethodType.instant
                            ? 'withdrawSuccessfulScreen.instantPayoutTitle'
                            : 'withdrawSuccessfulScreen.regularPayoutTitle',
                      ),
                      textAlign: TextAlign.center,
                      style: AppTextTheme.manrope24SemiBold,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      FlutterI18n.translate(
                        context,
                        withdrawMethodType == WithdrawMethodType.instant
                            ? 'withdrawSuccessfulScreen.instantPayoutSubtitle'
                            : 'withdrawSuccessfulScreen.regularPayoutSubtitle',
                      ),
                      style: AppTextTheme.manrope14Medium.copyWith(
                        color: AppTheme.textDescriptionColor,
                      ),
                    ),
                    const SizedBox(height: 36),
                    Text(
                      '${FlutterI18n.translate(context, 'withdrawSuccessfulScreen.newTackBalance')} \$ 0.00',
                      style: AppTextTheme.manrope20Bold.copyWith(
                        color: AppTheme.grassColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            TackButton(
              title: 'Close',
              onTap: () => BlocProvider.of<WithdrawSuccessfulBloc>(context).add(
                const CloseRequest(),
              ),
            ),
            const SizedBox(height: 100),
          ],
        );
      },
    );
  }
}
