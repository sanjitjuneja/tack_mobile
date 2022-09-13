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
              return state.currentFeePercent == 0 && !state.isLoading
                  ? Text(
                      FlutterI18n.translate(
                        context,
                        'addToTackBalanceScreen.noTransactionFee',
                      ),
                      style: AppTextTheme.manrope16Regular.copyWith(
                        color: AppTheme.grassColor,
                      ),
                    )
                  : Container();
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
