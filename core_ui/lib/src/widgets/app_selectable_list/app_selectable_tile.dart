part of app_selectable_list;

class AppBaseSelectableTile<T extends AppSelectableItem>
    extends StatelessWidget {
  final bool isSelected;
  final T item;
  final OnItemSelect<T> onItemTap;
  final EdgeInsets? padding;
  final BoxConstraints? constraints;

  const AppBaseSelectableTile({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onItemTap,
    this.padding,
    this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return OpacityOnTapContainer(
      onTap: () => onItemTap(item, context),
      child: Container(
        padding: padding?.copyWith(left: 0, right: 10) ??
            const EdgeInsets.only(
              left: 0,
              top: 10,
              right: 10,
              bottom: 10,
            ),
        constraints: constraints ?? const BoxConstraints(minHeight: 65),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            if (item.imagePath != null) ...<Widget>[
              AppCircleAvatarWidget(item.imagePath),
              const SizedBox(width: 20),
            ],
            Expanded(
              child: Text(
                item.title,
                style: AppTextTheme.poppins14Medium.copyWith(
                  color: isSelected
                      ? AppTheme.selectedListItemColor
                      : AppTheme.unselectedListItemColor,
                ),
              ),
            ),
            SizedBox(
              width: 24,
              height: 24,
              child: Visibility(
                visible: isSelected,
                child: AppImagesTheme.checkMarkRounded,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
