part of pick_group;

class PickGroupFeature {
  static const String routeName = '/pickGroup';

  static Page<Group> page(
    Group? selectedGroup,
  ) {
    return _PickGroupFeaturePage(
      selectedGroup: selectedGroup,
    );
  }
}

class _PickGroupFeaturePage extends Page<Group> {
  final Group? selectedGroup;

  @override
  String get name => PickGroupFeature.routeName;

  const _PickGroupFeaturePage({
    required this.selectedGroup,
  });

  @override
  Route<Group> createRoute(BuildContext context) {
    return CupertinoPageRoute<Group>(
      settings: this,
      builder: (_) {
        return BlocProvider<GroupsBloc>(
          create: (_) {
            return GroupsBloc(
              loadGroupsUseCase: appLocator.get<LoadGroupsUseCase>(),
              observeGroupIntentUseCase:
                  appLocator.get<ObserveGroupIntentUseCase>(),
            );
          },
          child: _PickGroupScreen(
            selectedGroup: selectedGroup,
          ),
        );
      },
    );
  }
}
