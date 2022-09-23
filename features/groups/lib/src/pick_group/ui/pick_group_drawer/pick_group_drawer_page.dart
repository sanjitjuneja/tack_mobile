part of pick_group;

class PickGroupDrawerFeature {
  static const String routeName = '/pickGroup';

  static Page<Group> page(
    Group? selectedGroup,
  ) {
    return _PickGroupDrawerPage(
      selectedGroup: selectedGroup,
    );
  }
}

class _PickGroupDrawerPage extends Page<Group> {
  final Group? selectedGroup;

  @override
  String get name => PickGroupDrawerFeature.routeName;

  const _PickGroupDrawerPage({
    required this.selectedGroup,
  });

  @override
  Route<Group> createRoute(BuildContext context) {
    return TopSlideRoute<Group>(
      settings: this,
      constraints: const BoxConstraints(maxHeight: 220),
      builder: (_) {
        return BlocProvider<GroupsBloc>(
          create: (_) {
            return GroupsBloc(
              appLifeCycleProvider: appLocator.get<AppLifeCycleProvider>(),
              loadGroupsUseCase: appLocator.get<LoadGroupsUseCase>(),
              observeGroupIntentUseCase:
                  appLocator.get<ObserveGroupIntentUseCase>(),
            );
          },
          child: _PickGroupDrawerForm(
            selectedGroup: selectedGroup,
          ),
        );
      },
    );
  }
}
