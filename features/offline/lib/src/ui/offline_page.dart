import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

import 'offline_screen.dart';

class OfflineFeature {
  static const String routeName = '/offline';

  static Page<void> page() {
    return const _OfflinePage();
  }
}

class _OfflinePage extends Page<void> {
  @override
  String get name => OfflineFeature.routeName;

  const _OfflinePage();

  @override
  Route<void> createRoute(BuildContext context) {
    return OpacityRoute<void>(
      settings: this,
      builder: (_) => OfflineScreen(
        getCurrentUserUseCase: appLocator.get<GetCurrentUserUseCase>(),
      ),
    );
  }
}
