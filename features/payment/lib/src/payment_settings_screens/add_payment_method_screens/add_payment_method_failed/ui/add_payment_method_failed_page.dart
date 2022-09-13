import 'package:flutter/cupertino.dart';

import 'add_payment_method_failed_screen.dart';

class AddPaymentMethodFailedFeature {
  static const String routeName = '/addPaymentMethodFailed';

  static Page<void> page({
    required String titleKey,
    required String descriptionKey,
  }) {
    return AddPaymentMethodFailedPage(
      titleKey: titleKey,
      descriptionKey: descriptionKey,
    );
  }
}

class AddPaymentMethodFailedPage extends Page<void> {
  final String titleKey;
  final String descriptionKey;

  @override
  String get name => AddPaymentMethodFailedFeature.routeName;

  const AddPaymentMethodFailedPage({
    required this.titleKey,
    required this.descriptionKey,
  });

  @override
  Route<void> createRoute(BuildContext context) {
    return CupertinoPageRoute<void>(
      settings: this,
      builder: (_) => AddPaymentMethodFailedScreen(
        titleKey: titleKey,
        descriptionKey: descriptionKey,
      ),
    );
  }
}
