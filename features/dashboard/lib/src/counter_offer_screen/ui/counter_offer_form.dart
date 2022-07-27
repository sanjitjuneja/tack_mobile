import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:dashboard/src/counter_offer_screen/bloc/counter_offer_bloc.dart';
import 'package:dashboard/src/widgets/tack_tile.dart';
import 'package:flutter/cupertino.dart';

class CounterOfferForm extends StatelessWidget {
  const CounterOfferForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterOfferBloc, CounterOfferState>(
      builder: (_, CounterOfferState state) {
        return Column(
          children: <Widget>[
            Expanded(
              child: CupertinoScrollbar(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        FlutterI18n.translate(
                          context,
                          'counterOfferScreen.tackDetails',
                        ),
                        style: AppTextTheme.manrope20Light,
                      ),
                      const SizedBox(height: 18),
                      TackTile(
                        tack: state.tack,
                        withActions: false,
                      ),
                      const SizedBox(height: 35),
                      Text(
                        FlutterI18n.translate(
                          context,
                          'counterOfferScreen.counterofferPrice',
                        ),
                        style: AppTextTheme.manrope20Light,
                      ),
                      const SizedBox(height: 15),
                      AppTextField(
                        placeholder: 'general.price',
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        inputFormatters: CurrencyUtility.dollarInputFormatters,
                        onTextChange: (String value) =>
                            _onCounterOfferChange(context, value),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            KeyboardVisibilityWidget(
              padding: const EdgeInsets.only(bottom: 40),
              child: AppCircleButton(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                isDisabled: !state.isOfferValid,
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
    BlocProvider.of<CounterOfferBloc>(context)
        .add(CounterOfferChange(counterOffer: value));
  }

  void _onCounterOfferSendPress(BuildContext context) {
    BlocProvider.of<CounterOfferBloc>(context).add(CounterOfferSend());
  }
}
