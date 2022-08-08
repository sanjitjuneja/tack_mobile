import 'package:customer_support/ui/customer_support_page.dart';
import 'package:flutter/cupertino.dart';

class CustomerSupport {
  static const String routeName = '/customerSupport';

  static Page<void> page() {
    return const CustomerSupportPage();
  }
}
