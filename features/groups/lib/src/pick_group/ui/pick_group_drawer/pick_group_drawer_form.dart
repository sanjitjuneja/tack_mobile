part of pick_group;

class _PickGroupDrawerForm extends StatelessWidget {
  final Group? selectedGroup;

  const _PickGroupDrawerForm({
    required this.selectedGroup,
  });

  @override
  Widget build(BuildContext context) {
    final _SelectableGroup? selectedGroup = this.selectedGroup == null
        ? null
        : _SelectableGroup(this.selectedGroup!);

    return BlocBuilder<GroupsBloc, GroupsState>(
      builder: (_, GroupsState state) {
        return Container(
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
          child: SafeArea(
            bottom: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
                  child: AppListViewWithRefresh(
                    enableRefresh: true,
                    enableLoad: state.canLoadMore,
                    isLoading: state.isLoading,
                    hasData: state.hasData,
                    onRefresh: _onRefreshAction,
                    onLoad: _onLoadMoreAction,
                    refreshIndicatorSize: ProgressIndicatorSize.small,
                    loadingIndicatorSize: ProgressIndicatorSize.medium,
                    indicatorColor: AppTheme.progressInterfaceDarkColor,
                    separatorBuilder: (_, __) => const AppDivider(),
                    itemBuilder: (_, int index) {
                      final _SelectableGroup selectableGroup = _SelectableGroup(
                        state.groups[index],
                      );

                      return AppBaseSelectableTile<_SelectableGroup>(
                        item: selectableGroup,
                        isSelected: selectedGroup == selectableGroup,
                        onItemTap: _onItemSelect,
                      );
                    },
                    itemCount: state.groups.length,
                  ),
                ),
                const SizedBox(height: 12),
                const DrawerAccessoryWidget(),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onRefreshAction(
    BuildContext context,
    Completer<RefreshingStatus> completer,
  ) {
    BlocProvider.of<GroupsBloc>(context)
        .add(RefreshAction(completer: completer));
  }

  void _onLoadMoreAction(
    BuildContext context,
    Completer<LoadingStatus> completer,
  ) {
    BlocProvider.of<GroupsBloc>(context)
        .add(LoadMoreAction(completer: completer));
  }

  Future<void> _onItemSelect(
    _SelectableGroup selectableGroup,
    BuildContext context,
  ) async {
    AppRouter.of(context).popWithResult(selectableGroup.group);
  }
}
