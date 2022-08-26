import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import 'package:groups/src/create_group/bloc/create_group_bloc.dart';
import 'package:groups/src/create_group/ui/create_group_screen.dart';

class CreateGroupFeature {
  static const String routeName = '/createGroup';

  static Page<Group> page() {
    return const _CreateGroupPage();
  }
}

class _CreateGroupPage extends Page<Group> {
  const _CreateGroupPage();

  @override
  String get name => CreateGroupFeature.routeName;

  @override
  Route<Group> createRoute(BuildContext context) {
    return CupertinoPageRoute<Group>(
      settings: this,
      builder: (_) => BlocProvider<CreateGroupBloc>(
        create: (_) {
          return CreateGroupBloc(
            appRouter: AppRouter.of(context),
            createGroupUseCase: appLocator.get<CreateGroupUseCase>(),
          );
        },
        child: const CreateGroupScreen(),
      ),
    );
  }
}
