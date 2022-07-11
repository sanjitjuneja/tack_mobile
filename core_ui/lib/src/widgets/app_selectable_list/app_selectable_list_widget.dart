part of app_selectable_list;

class AppSelectableList<T extends AppSelectableItem> extends StatefulWidget {
  final List<T> items;
  final T? selectedItem;
  final bool dismissOnItemTap;
  final OnItemSelect<T>? onItemSelect;

  const AppSelectableList({
    super.key,
    required this.items,
    required this.selectedItem,
    this.dismissOnItemTap = false,
    this.onItemSelect,
  });

  @override
  State<AppSelectableList> createState() => _AppSelectableListState<T>();
}

class _AppSelectableListState<T extends AppSelectableItem>
    extends State<AppSelectableList<T>> {
  static const _autoPopDuration = Duration(milliseconds: 140);

  T? selectedItem;

  @override
  void initState() {
    selectedItem = widget.selectedItem;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: AppTheme.transparentColor,
      ),
      child: ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (_, __) => const AppDivider(),
        itemBuilder: (_, int index) {
          final T item = widget.items[index];

          return AppBaseSelectableTile<T>(
            item: item,
            onItemTap: _onItemTap,
            isSelected: item == selectedItem,
          );
        },
        itemCount: widget.items.length,
      ),
    );
  }

  Future<void> _onItemTap(T item, BuildContext context) async {
    widget.onItemSelect?.call(item, context);
    setState(() => selectedItem = item);

    if (widget.dismissOnItemTap) {
      await Future.delayed(
        _autoPopDuration,
        () => Navigator.of(context).pop(selectedItem),
      );
    }
  }
}
