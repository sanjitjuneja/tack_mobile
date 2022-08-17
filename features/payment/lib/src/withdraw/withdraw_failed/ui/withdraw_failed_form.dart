import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import '../bloc/withdraw_failed_bloc.dart';

class WithdrawFailedForm extends StatelessWidget {
  const WithdrawFailedForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WithdrawFailedBloc, WithdrawFailedState>(
      builder: (context, state) {
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
                          'withdrawFailedScreen.title',
                        ),
                        style: AppTextTheme.manrope32Bold,
                      ),
                    ),
                    const Spacer(),
                    AppIconsTheme.redCrossRounded.call(size: 120),
                    const Spacer(),
                    Text(
                      FlutterI18n.translate(
                        context,
                        'withdrawFailedScreen.description',
                      ),
                      textAlign: TextAlign.center,
                      style: AppTextTheme.manrope14Medium.copyWith(
                        color: AppTheme.textHeavyHintColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(flex: 3),
            Row(
              children: <Widget>[
                const Spacer(),
                Expanded(
                  flex: 4,
                  child: AppCircleButton(
                    labelKey: 'withdrawFailedScreen.close',
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
    BlocProvider.of<WithdrawFailedBloc>(context).add(
      const CloseRequest(),
    );
  }
}
