import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import '../bloc/add_credit_card_bloc.dart';

class AddCreditCardForm extends StatelessWidget {
  const AddCreditCardForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCreditCardBloc, AddCreditCardState>(
      builder: (context, AddCreditCardState state) {
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
              const CardFormField(countryCode: 'US'),
              const Spacer(flex: 6),
              Row(
                children: <Widget>[
                  const Spacer(),
                  Expanded(
                    flex: 4,
                    child: AppCircleButton(
                      labelKey: 'addCreditCard.addPaymentMethod',
                      expanded: false,
                      onTap: () {},
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              const Spacer(),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
