import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import '../bloc/tack_options_bloc.dart';
import 'tack_options_drawer_form.dart';

class TackOptionsDrawerFeature {
  static const String routeName = '/tackOptions';

  static Page<void> page() {
    return const _TackOptionsDrawerPage();
  }
}

class _TackOptionsDrawerPage extends Page<void> {
  @override
  String get name => TackOptionsDrawerFeature.routeName;

  const _TackOptionsDrawerPage();

  @override
  Route<void> createRoute(BuildContext context) {
    return BottomSlideRoute<void>(
      settings: this,
      builder: (_) {
        return BlocProvider(
          create: (_) {
            return TackOptionsBloc(
              appRouter: AppRouter.of(context),
            );
          },
          child: const TackOptionsDrawerForm(),
        );
      },
    );
  }
}
