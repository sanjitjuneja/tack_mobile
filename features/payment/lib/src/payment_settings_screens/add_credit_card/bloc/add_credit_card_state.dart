part of 'add_credit_card_bloc.dart';

class AddCreditCardState {
  final CardFieldInputDetails card;

  const AddCreditCardState({
    required this.card,
  });

  AddCreditCardState copyWith({
    CardFieldInputDetails? card,
  }) {
    return AddCreditCardState(
      card: card ?? this.card,
    );
  }
}
