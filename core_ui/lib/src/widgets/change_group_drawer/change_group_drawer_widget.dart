part of group_drawer;

class _ChangeGroupDrawerWidget extends StatelessWidget {
  static const _autoPopDuration = Duration(milliseconds: 140);

  final List<Group> _groups;
  final Group? _currentGroup;

  const _ChangeGroupDrawerWidget(
    this._groups,
    this._currentGroup,
  );

  @override
  Widget build(BuildContext context) {
    final List<SelectableGroup> groups = List<SelectableGroup>.from(
      _groups.map(SelectableGroup.new),
    );
    final SelectableGroup? currentGroup =
        _currentGroup == null ? null : SelectableGroup(_currentGroup!);

    return Material(
      color: AppTheme.transparentColor,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: AppTheme.primaryColor,
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 0,
          vertical: 0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: CupertinoScrollbar(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomScrollView(
                    shrinkWrap: true,
                    slivers: <Widget>[
                      SliverSafeArea(
                        bottom: false,
                        sliver: SliverToBoxAdapter(
                          child: AppSelectableList<SelectableGroup>(
                            items: groups,
                            selectedItem: currentGroup,
                            onItemSelect: _onItemSelect,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const DrawerAccessoryWidget(),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Future<void> _onItemSelect(
    SelectableGroup selectableGroup,
    BuildContext context,
  ) async {
    await Future.delayed(
      _autoPopDuration,
      () => AppRouter.of(context).popWithResult(selectableGroup.group),
    );
  }
}
