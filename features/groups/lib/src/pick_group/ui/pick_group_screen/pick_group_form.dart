part of pick_group;

class _PickGroupForm extends StatelessWidget {
  final Group? selectedGroup;

  const _PickGroupForm({
    required this.selectedGroup,
  });

  @override
  Widget build(BuildContext context) {
    final _SelectableGroup? selectedGroup = this.selectedGroup == null
        ? null
        : _SelectableGroup(this.selectedGroup!);

    return BlocBuilder<GroupsBloc, GroupsState>(
      builder: (_, GroupsState state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                FlutterI18n.translate(context, 'pickGroupScreen.title'),
                style: AppTextTheme.poppins14Medium
                    .copyWith(color: AppTheme.textPrimaryColor),
              ),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: AppListViewWithRefresh(
                enableRefresh: true,
                enableLoad: state.canLoadMore,
                isLoading: state.isLoading,
                hasData: state.hasData,
                onRefresh: _onRefreshAction,
                onLoad: _onLoadMoreAction,
                indicatorColor: AppTheme.progressInterfaceDarkColor,
                separatorBuilder: (_, __) => const AppDivider(),
                itemBuilder: (_, int index) {
                  final _SelectableGroup selectableGroup = _SelectableGroup(
                    state.groups[index].group,
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
          ],
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
