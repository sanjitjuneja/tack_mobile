part of app_refresh_widgets;

class AppListViewWithRefresh extends StatelessWidget {
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final IndexedWidgetBuilder? separatorBuilder;
  final bool isLoading;
  final bool hasData;
  final Widget? emptyWidget;
  final Widget? headerWidget;
  final Widget? footerWidget;
  final bool enableLoad;
  final bool enableRefresh;
  final LoadCallback? onLoad;
  final RefreshCallback? onRefresh;
  final ProgressIndicatorSize refreshIndicatorSize;
  final ProgressIndicatorSize loadingIndicatorSize;
  final Color? indicatorColor;
  final EdgeInsets? padding;

  const AppListViewWithRefresh({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
    this.separatorBuilder,
    this.isLoading = false,
    this.hasData = true,
    this.emptyWidget,
    this.headerWidget,
    this.footerWidget,
    this.enableLoad = true,
    this.enableRefresh = true,
    this.onLoad,
    this.onRefresh,
    this.refreshIndicatorSize = ProgressIndicatorSize.medium,
    this.loadingIndicatorSize = ProgressIndicatorSize.big,
    this.indicatorColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return _RefreshWidget(
      key: key,
      itemBuilder: itemBuilder,
      itemCount: itemCount,
      separatorBuilder: separatorBuilder,
      isLoading: isLoading,
      hasData: hasData,
      emptyWidget: emptyWidget,
      headerWidget: headerWidget,
      footerWidget: footerWidget,
      enableLoad: enableLoad,
      enableRefresh: enableRefresh,
      onLoad: onLoad,
      onRefresh: onRefresh,
      refreshIndicatorSize: refreshIndicatorSize,
      loadingIndicatorSize: loadingIndicatorSize,
      indicatorColor: indicatorColor,
      padding: padding,
    );
  }
}
