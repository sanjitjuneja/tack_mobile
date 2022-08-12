import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import '../../bloc/groups_bloc.dart';
import '../bloc/my_groups_bloc.dart';
import 'my_groups_screen.dart';

class MyGroupsFeature {
  static const String routeName = '/myGroups';

  static Page<Group> page() {
    return const _MyGroupsPage();
  }
}

class _MyGroupsPage extends Page<Group> {
  @override
  String get name => MyGroupsFeature.routeName;

  const _MyGroupsPage();

  @override
  Route<Group> createRoute(BuildContext context) {
    return CupertinoPageRoute<Group>(
      settings: this,
      builder: (_) => MultiBlocProvider(
        providers: <BlocProvider<dynamic>>[
          BlocProvider<MyGroupsBloc>(
            create: (_) {
              return MyGroupsBloc(
                appRouter: AppRouter.of(context),
              );
            },
          ),
          BlocProvider<GroupsBloc>(
            create: (_) {
              return GroupsBloc(
                loadGroupsUseCase: appLocator.get<LoadGroupsUseCase>(),
              );
            },
          ),
        ],
        child: const MyGroupsScreen(),
      ),
    );
  }
}
