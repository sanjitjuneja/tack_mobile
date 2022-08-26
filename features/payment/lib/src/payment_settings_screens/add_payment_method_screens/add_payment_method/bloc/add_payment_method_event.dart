part of 'add_payment_method_bloc.dart';

abstract class AddPaymentMethodEvent {
  const AddPaymentMethodEvent();
}

class AddCreditCardRequest extends AddPaymentMethodEvent {
  const AddCreditCardRequest();
}

class AddBankAccountRequest extends AddPaymentMethodEvent {
  const AddBankAccountRequest();
}
