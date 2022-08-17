import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import '../bloc/add_to_tack_balance_successful_bloc.dart';


class AddToTackBalanceSuccessfulForm extends StatelessWidget {
  const AddToTackBalanceSuccessfulForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddToTackBalanceSuccessfulBloc, AddToTackBalanceSuccessfulState>(
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
                      '${FlutterI18n.translate(
                        context,
                        'addToTackBalanceSuccessfulScreen.newTackBalance',
                      )} \$ 0.00',
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
            const SizedBox(height: 100),
          ],
        );
      },
    );
  }

  void _onClosePress(BuildContext context) {
    BlocProvider.of<AddToTackBalanceSuccessfulBloc>(context).add(
      const CloseRequest(),
    );
  }
}
