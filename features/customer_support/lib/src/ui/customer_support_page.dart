import 'package:flutter/cupertino.dart';

import 'customer_support_screen.dart';

class CustomerSupportFeature {
  static const String routeName = '/customerSupport';

  static Page<void> page() {
    return const _CustomerSupportPage();
  }
}

class _CustomerSupportPage extends Page<void> {
  const _CustomerSupportPage();

  @override
  Route<void> createRoute(BuildContext context) {
    return CupertinoPageRoute<void>(
      settings: this,
      builder: (_) => const CustomerSupportScreen(),
    );
  }
}
