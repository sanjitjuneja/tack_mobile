part of 'add_credit_card_bloc.dart';

abstract class AddCreditCardEvent {
  const AddCreditCardEvent();
}

class AddCreditCardChange extends AddCreditCardEvent {
  final CardFieldInputDetails? card;

  const AddCreditCardChange({required this.card});
}

class AddNewCreditCard extends AddCreditCardEvent {
  const AddNewCreditCard();
}
