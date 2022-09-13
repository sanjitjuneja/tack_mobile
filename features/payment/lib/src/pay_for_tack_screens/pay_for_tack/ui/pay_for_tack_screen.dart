import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import '../bloc/pay_for_tack_bloc.dart';
import 'pay_for_tack_form.dart';

class PayForTackScreen extends StatelessWidget {
  const PayForTackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.secondaryBackgroundColor,
      navigationBar: AppNavigationBar(
        backgroundColor: AppTheme.secondaryBackgroundColor,
        withResult: false,
        actions: <Widget>[
          BlocBuilder<PayForTackBloc, PayForTackState>(
            builder: (_, PayForTackState state) {
              return Row(
                children: <Widget>[
                  TimeLeftWidget(
                    tillTime: state.offer.expiredAt,
                    builder: (_, String content) {
                      return RichText(
                        text: TextSpan(
                          text: content,
                          style: AppTextTheme.manrope14Regular.copyWith(
                            color: AppTheme.errorColor,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: FlutterI18n.translate(
                                context,
                                'payForTack.untilOfferExpires',
                              ),
                              style: AppTextTheme.manrope14Regular.copyWith(
                                color: AppTheme.textHeavyHintColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
      child: const SafeArea(
        child: PayForTackForm(),
      ),
    );
  }
}
