import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import '../bloc/add_to_tack_balance_bloc.dart';
import 'add_to_tack_balance_form.dart';

class AddToTackBalanceScreen extends StatelessWidget {
  const AddToTackBalanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.secondaryBackgroundColor,
      navigationBar: AppNavigationBar(
        backgroundColor: AppTheme.secondaryBackgroundColor,
        withResult: false,
        actions: <Widget>[
          BlocBuilder<AddToTackBalanceBloc, AddToTackBalanceState>(
            builder: (_, AddToTackBalanceState state) {
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
        child: AddToTackBalanceForm(),
      ),
    );
  }
}
