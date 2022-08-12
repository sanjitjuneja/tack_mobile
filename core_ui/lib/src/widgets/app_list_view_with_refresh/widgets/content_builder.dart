part of app_list_view_with_refresh;

class _ContentBuilder extends StatelessWidget {
  final bool isLoading;
  final bool hasData;
  final IndexedWidgetBuilder? separatorBuilder;
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final ProgressIndicatorSize loadingIndicatorSize;
  final Color? indicatorColor;
  final Widget? emptyWidget;
  final Widget? headerWidget;
  final Widget? footerWidget;
  final EdgeInsets? padding;

  const _ContentBuilder({
    required this.isLoading,
    required this.hasData,
    required this.separatorBuilder,
    required this.itemBuilder,
    required this.itemCount,
    required this.loadingIndicatorSize,
    this.indicatorColor,
    this.emptyWidget,
    this.headerWidget,
    this.footerWidget,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _LoadStateWidget(
        indicatorSize: loadingIndicatorSize,
        indicatorColor: indicatorColor,
      );
    }

    final bool hasHeader = headerWidget != null;
    final bool hasFooter = footerWidget != null;
    Widget? header;
    Widget? footer;
    final Widget content;

    if (hasHeader) {
      final EdgeInsets headerPadding;
      if (padding == null) {
        headerPadding = const EdgeInsets.fromLTRB(16, 12, 16, 0);
      } else {
        headerPadding = EdgeInsets.fromLTRB(
          padding?.left ?? 16,
          12,
          padding?.right ?? 16,
          0,
        );
      }

      header = SliverToBoxAdapter(
        child: Padding(
          padding: headerPadding,
          child: headerWidget!,
        ),
      );
    }

    if (hasFooter && hasData) {
      final EdgeInsets footerPadding;
      if (padding == null) {
        footerPadding = const EdgeInsets.fromLTRB(16, 0, 16, 12);
      } else {
        footerPadding = EdgeInsets.fromLTRB(
          padding?.left ?? 16.0,
          0,
          padding?.right ?? 16.0,
          12.0,
        );
      }

      footer = SliverToBoxAdapter(
        child: Padding(
          padding: footerPadding,
          child: footerWidget!,
        ),
      );
    }

    if (hasData) {
      content = SliverToBoxAdapter(
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: padding ?? const EdgeInsets.fromLTRB(16, 12, 16, 12),
          itemBuilder: itemBuilder,
          separatorBuilder:
              separatorBuilder ?? (_, __) => const SizedBox(height: 12.0),
          itemCount: itemCount,
        ),
      );
    } else {
      content = SliverFillRemaining(
        child: emptyWidget ?? const SizedBox.shrink(),
      );
    }

    return CustomScrollView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      slivers: <Widget>[
        if (header != null) header,
        content,
        if (footer != null) footer,
      ],
    );
  }
}
