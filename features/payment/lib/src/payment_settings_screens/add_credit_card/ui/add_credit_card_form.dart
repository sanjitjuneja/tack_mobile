import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import '../../widgets/payment_info_label.dart';
import '../bloc/add_credit_card_bloc.dart';

class AddCreditCardForm extends StatelessWidget {
  const AddCreditCardForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCreditCardBloc, AddCreditCardState>(
      builder: (_, AddCreditCardState state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                FlutterI18n.translate(
                  context,
                  'addCreditCard.title',
                ),
                style: AppTextTheme.manrope20Regular,
              ),
              const SizedBox(height: 6),
              Text(
                FlutterI18n.translate(
                  context,
                  'addCreditCard.description',
                ),
                style: AppTextTheme.manrope16Regular.copyWith(
                  color: AppTheme.textHeavyHintColor,
                ),
              ),
              const SizedBox(height: 30),
              CardField(
                enablePostalCode: false,
                onCardChanged: (card) => _onCardChange(
                  context: context,
                  card: card,
                ),
              ),
              const Spacer(flex: 10),
              Row(
                children: <Widget>[
                  const Spacer(),
                  Expanded(
                    flex: 10,
                    child: AppCircleButton(
                      labelKey: 'addCreditCard.addPaymentMethod',
                      expanded: false,
                      isDisabled: !state.card.complete,
                      onTap: () => _onAddCreditCardTileTap(context),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              const Spacer(),
              const PaymentInfoLabel(),
              const SizedBox(height: 34),
            ],
          ),
        );
      },
    );
  }

  void _onAddCreditCardTileTap(BuildContext context) {
    BlocProvider.of<AddCreditCardBloc>(context).add(
      const AddNewCreditCard(),
    );
  }

  void _onCardChange({
    required BuildContext context,
    required CardFieldInputDetails? card,
  }) {
    BlocProvider.of<AddCreditCardBloc>(context).add(
      AddCreditCardChange(card: card),
    );
  }
}
