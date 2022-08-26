import 'package:flutter/cupertino.dart';
import 'add_payment_method_failed_screen.dart';

class AddPaymentMethodFailedFeature {
  static const String routeName = '/addPaymentMethodFailed';

  static Page<void> page({
    String? labelKey,
  }) {
    return AddPaymentMethodFailedPage(
      labelKey: labelKey,
    );
  }
}

class AddPaymentMethodFailedPage extends Page<void> {
  final String? labelKey;

  @override
  String get name => AddPaymentMethodFailedFeature.routeName;

  const AddPaymentMethodFailedPage({
    this.labelKey,
  });

  @override
  Route<void> createRoute(BuildContext context) {
    return CupertinoPageRoute<void>(
      settings: this,
      builder: (_) => AddPaymentMethodFailedScreen(
        labelKey: labelKey,
      ),
    );
  }
}
