import 'package:flutter/cupertino.dart';

import 'withdraw_failed_screen.dart';

class WithdrawFailedFeature {
  static const String routeName = '/withdrawFailed';

  static Page<void> page({
    required String errorKey,
  }) {
    return WithdrawFailedPage(
      errorKey: errorKey,
    );
  }
}

class WithdrawFailedPage extends Page<void> {
  final String errorKey;

  @override
  String get name => WithdrawFailedFeature.routeName;

  const WithdrawFailedPage({
    required this.errorKey,
  });

  @override
  Route<void> createRoute(BuildContext context) {
    return CupertinoPageRoute<void>(
      settings: this,
      builder: (_) => WithdrawFailedScreen(
        errorKey: errorKey,
      ),
    );
  }
}
