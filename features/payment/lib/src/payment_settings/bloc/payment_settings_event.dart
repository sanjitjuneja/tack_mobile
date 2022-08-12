part of 'payment_settings_bloc.dart';

abstract class PaymentSettingsEvent {
  const PaymentSettingsEvent();
}

class AddPaymentMethodRequest extends PaymentSettingsEvent {
  const AddPaymentMethodRequest();
}
