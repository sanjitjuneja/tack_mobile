import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import '../bloc/add_payment_method_failed_bloc.dart';

class AddPaymentMethodFailedForm extends StatelessWidget {
  const AddPaymentMethodFailedForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPaymentMethodFailedBloc, AddPaymentMethodFailedState>(
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
                          'addPaymentMethodFailedScreen.title',
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
                        'addPaymentMethodFailedScreen.description',
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
                    labelKey: 'addPaymentMethodFailedScreen.close',
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
    BlocProvider.of<AddPaymentMethodFailedBloc>(context).add(
      const CloseRequest(),
    );
  }
}
