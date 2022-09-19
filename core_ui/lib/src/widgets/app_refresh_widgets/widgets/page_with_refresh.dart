part of app_refresh_widgets;

class AppPageWithRefresh extends StatelessWidget {
  final Widget contentWidget;
  final bool isLoading;
  final bool hasData;
  final Widget? emptyWidget;
  final Widget? headerWidget;
  final Widget? footerWidget;
  final bool enableRefresh;
  final RefreshCallback? onRefresh;
  final ProgressIndicatorSize refreshIndicatorSize;
  final ProgressIndicatorSize loadingIndicatorSize;
  final Color? indicatorColor;
  final EdgeInsets? padding;

  const AppPageWithRefresh({
    super.key,
    required this.contentWidget,
    this.isLoading = false,
    this.hasData = true,
    this.emptyWidget,
    this.headerWidget,
    this.footerWidget,
    this.enableRefresh = true,
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
      contentWidget: contentWidget,
      itemBuilder: null,
      itemCount: null,
      separatorBuilder: null,
      isLoading: isLoading,
      hasData: hasData,
      emptyWidget: emptyWidget,
      headerWidget: headerWidget,
      footerWidget: footerWidget,
      enableLoad: false,
      enableRefresh: enableRefresh,
      onLoad: null,
      onRefresh: onRefresh,
      refreshIndicatorSize: refreshIndicatorSize,
      loadingIndicatorSize: loadingIndicatorSize,
      indicatorColor: indicatorColor,
      padding: padding,
    );
  }
}
