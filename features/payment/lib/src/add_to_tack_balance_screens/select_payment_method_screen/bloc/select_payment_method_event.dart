part of 'select_payment_method_bloc.dart';

abstract class SelectPaymentMethodEvent {
  const SelectPaymentMethodEvent();
}

class InitialLoad extends SelectPaymentMethodEvent {
  const InitialLoad();
}

class SelectPaymentMethodAction extends SelectPaymentMethodEvent {
  final String paymentMethodId;

  const SelectPaymentMethodAction({
    required this.paymentMethodId,
  });
}

class AddPaymentMethodAction extends SelectPaymentMethodEvent {
  const AddPaymentMethodAction();
}
