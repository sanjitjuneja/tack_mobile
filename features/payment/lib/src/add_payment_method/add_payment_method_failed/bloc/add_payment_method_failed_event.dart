part of 'add_payment_method_failed_bloc.dart';

abstract class AddPaymentMethodFailedEvent {
  const AddPaymentMethodFailedEvent();
}

class CloseRequest extends AddPaymentMethodFailedEvent {
  const CloseRequest();
}
