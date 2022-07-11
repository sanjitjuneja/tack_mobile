import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:dashboard/src/counter_offer_screen/bloc/counter_offer_bloc.dart';
import 'package:dashboard/src/widgets/tack_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

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
                        'Tack Details',
                        style: AppTextTheme.manrope20Regular,
                      ),
                      const SizedBox(height: 18),
                      TackTile(
                        tack: state.tack,
                        withActions: false,
                      ),
                      const SizedBox(height: 35),
                      Text(
                        'Counteroffer Price',
                        style: AppTextTheme.manrope20Regular,
                      ),
                      const SizedBox(height: 15),
                      AppTextField(
                        placeholder: 'Price',
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}'),
                          ),
                        ],
                        onTextChange: (String value) =>
                            _onCounterOfferChange(context, value),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            KeyboardVisibilityBuilder(
              builder: (_, bool isKeyboardVisible) {
                return AnimatedPadding(
                  padding: EdgeInsets.only(bottom: isKeyboardVisible ? 0 : 40),
                  duration: const Duration(milliseconds: 250),
                  child: AnimatedOpacity(
                    opacity: isKeyboardVisible ? 0 : 1,
                    duration: const Duration(milliseconds: 400),
                    curve: isKeyboardVisible
                        ? Curves.linearToEaseOut
                        : Curves.fastOutSlowIn,
                    child: AppCircleButton(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      isDisabled: !state.isOfferValid,
                      label: 'Send Offer',
                      onTap: () => _onCounterOfferSendPress(context),
                    ),
                  ),
                );
              },
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
