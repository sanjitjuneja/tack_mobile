part of app_list_view_with_refresh;

class _ContentBuilder extends StatelessWidget {
  final bool isLoading;
  final bool hasData;
  final BuilderFunction itemBuilder;
  final int itemCount;
  final Widget? emptyWidget;
  final Widget? footerWidget;

  const _ContentBuilder({
    required this.isLoading,
    required this.hasData,
    required this.itemBuilder,
    required this.itemCount,
    this.emptyWidget,
    this.footerWidget,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const _LoadStateWidget();

    if (hasData) {
      final bool hasFooter = footerWidget != null;

      final Widget listView = ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        itemBuilder: itemBuilder,
        separatorBuilder: (_, __) => const SizedBox(height: 12.0),
        itemCount: itemCount,
      );

      if (hasFooter) {
        return CustomScrollView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          slivers: <Widget>[
            SliverToBoxAdapter(child: listView),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 28),
              sliver: SliverToBoxAdapter(
                child: footerWidget!,
              ),
            ),
          ],
        );
      } else {
        return listView;
      }
    }

    return emptyWidget ?? const SizedBox.shrink();
  }
}
