import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:core_ui/core_ui.dart';
import 'package:navigation/navigation.dart';

import '../bloc/app_drawer_bloc.dart';
import 'app_drawer_widget.dart';
import 'widgets/app_drawer_close_button.dart';

class AppDrawer {
  static const String routeName = '/drawer';

  static Page<void> page() {
    return const _AppDrawerPage();
  }
}

class _AppDrawerPage extends Page<void> {
  @override
  String get name => AppDrawer.routeName;

  const _AppDrawerPage();

  @override
  Route<void> createRoute(BuildContext context) {
    return LeftSlideRoute<void>(
      settings: this,
      rightBorderWidget: const AppDrawerCloseButton(),
      builder: (_) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: BlocProvider<AppDrawerBloc>(
            create: (_) {
              return AppDrawerBloc(
                appRouterDelegate: appLocator.get<AppRouterDelegate>(),
                getCurrentUserUseCase: appLocator.get<GetCurrentUserUseCase>(),
                observeUserUseCase: appLocator.get<ObserveUserUseCase>(),
                getUserBalanceUseCase: appLocator.get<GetUserBalanceUseCase>(),
                observeUserBalanceUseCase:
                    appLocator.get<ObserveUserBalanceUseCase>(),
                fetchUserBalanceUseCase:
                    appLocator.get<FetchUserBalanceUseCase>(),
                logOutUseCase: appLocator.get<LogOutUseCase>(),
              );
            },
            child: const AppDrawerWidget(),
          ),
        );
      },
    );
  }
}
