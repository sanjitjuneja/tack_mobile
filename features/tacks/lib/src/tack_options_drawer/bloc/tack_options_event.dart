part of 'tack_options_bloc.dart';

abstract class TackOptionsEvent {
  const TackOptionsEvent();
}

class OpenCustomerSupport extends TackOptionsEvent {
  const OpenCustomerSupport();
}
