import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:payment/src/withdraw_screens/withdraw/bloc/withdraw_bloc.dart';
import 'withdraw_form.dart';

class WithdrawScreen extends StatelessWidget {
  const WithdrawScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.secondaryBackgroundColor,
      navigationBar: AppNavigationBar(
        backgroundColor: AppTheme.secondaryBackgroundColor,
        withResult: false,
        actions: <Widget>[
          BlocBuilder<WithdrawBloc, WithdrawState>(
            builder: (_, WithdrawState state) {
              return state.fee?.dwollaFeeData.feePercent == 0 &&
                      !state.isLoading
                  ? Text(
                      FlutterI18n.translate(
                        context,
                        'withdrawScreen.feeLabel',
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
        child: WithdrawForm(),
      ),
    );
  }
}
