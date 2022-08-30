import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import '../bloc/counter_offer_bloc.dart';
import '../../widgets/group_tack_tile.dart';

class CounterOfferForm extends StatelessWidget {
  const CounterOfferForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterOfferBloc, CounterOfferState>(
      builder: (_, CounterOfferState state) {
        return Column(
          children: <Widget>[
            Expanded(
              child: AppScrollView(
                children: <Widget>[
                  Text(
                    FlutterI18n.translate(
                      context,
                      'counterOfferScreen.tackDetails',
                    ),
                    style: AppTextTheme.manrope20Regular,
                  ),
                  const SizedBox(height: 18),
                  GroupTackTile(
                    groupTack: state.groupTack,
                    withActions: false,
                  ),
                  const SizedBox(height: 35),
                  Text(
                    FlutterI18n.translate(
                      context,
                      'counterOfferScreen.counterofferPrice',
                    ),
                    style: AppTextTheme.manrope20Regular,
                  ),
                  const SizedBox(height: 15),
                  AppTextField(
                    placeholder: 'general.price',
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    isInvalid: state.counterOfferData.isInvalid,
                    errorTextKey: 'counterOfferScreen.priceInvalid',
                    inputFormatters: CurrencyUtility.dollarInputFormatters(
                      maxValue: state.counterOfferData.maxValue,
                    ),
                    onTextChange: (String value) =>
                        _onCounterOfferChange(context, value),
                    onFocusLost: _onFocusLost,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            KeyboardVisibilityWidget(
              padding: const EdgeInsets.only(bottom: 40),
              child: AppCircleButton(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                labelKey: 'counterOfferScreen.sendOfferButton',
                onTap: () => _onCounterOfferSendPress(context),
              ),
            ),
          ],
        );
      },
    );
  }

  void _onCounterOfferChange(
    BuildContext context,
    String value,
  ) {
    BlocProvider.of<CounterOfferBloc>(context).add(
      CounterOfferChange(
        counterOffer: const CurrencyFormatter().removeFormat(value),
      ),
    );
  }

  void _onFocusLost(TextEditingController controller) {
    final String text = controller.text;
    final String unformattedText = const CurrencyFormatter().removeFormat(text);

    if (unformattedText.isNotEmpty) {
      final double value = double.parse(unformattedText);
      final String newText = CurrencyUtility.dollarFormat.format(value);

      controller.text = newText;
    }
  }

  void _onCounterOfferSendPress(BuildContext context) {
    BlocProvider.of<CounterOfferBloc>(context).add(CounterOfferSend());
  }
}
