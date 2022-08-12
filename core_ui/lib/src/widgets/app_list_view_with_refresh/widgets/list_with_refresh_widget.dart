part of app_list_view_with_refresh;

class AppListViewWithRefresh extends StatefulWidget {
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
  State<AppListViewWithRefresh> createState() => _AppListViewWithRefreshState();
}

class _AppListViewWithRefreshState extends State<AppListViewWithRefresh> {
  static const Duration _hapticFeedbackDelay = Duration(milliseconds: 400);

  late RefreshController _refreshController;

  bool get enableRefresh {
    if (widget.isLoading) return false;

    return widget.enableRefresh;
  }

  bool get enableLoad {
    if (widget.isLoading) return false;
    if (!widget.hasData) return false;

    return widget.enableLoad;
  }

  @override
  void initState() {
    _refreshController = RefreshController(initialRefresh: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double headerTriggerDistance = widget.refreshIndicatorSize.size * 3;
    final double footerTriggerDistance = widget.refreshIndicatorSize.size * 2;

    return RefreshConfiguration(
      headerTriggerDistance: headerTriggerDistance,
      footerTriggerDistance: footerTriggerDistance,
      child: CupertinoScrollbar(
        child: SmartRefresher(
          enablePullDown: enableRefresh,
          enablePullUp: enableLoad,
          header: _RefreshHeader(
            indicatorColor: widget.indicatorColor,
            indicatorSize: widget.refreshIndicatorSize,
          ),
          footer: _LoadMoreFooter(
            indicatorColor: widget.indicatorColor,
            indicatorSize: widget.refreshIndicatorSize,
          ),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoad,
          child: _ContentBuilder(
            isLoading: widget.isLoading,
            hasData: widget.hasData,
            separatorBuilder: widget.separatorBuilder,
            itemBuilder: widget.itemBuilder,
            itemCount: widget.itemCount,
            loadingIndicatorSize: widget.loadingIndicatorSize,
            indicatorColor: widget.indicatorColor,
            emptyWidget: widget.emptyWidget,
            headerWidget: widget.headerWidget,
            footerWidget: widget.footerWidget,
            padding: widget.padding,
          ),
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    final Completer<RefreshingStatus> completer = Completer<RefreshingStatus>();

    if (widget.onRefresh != null) {
      widget.onRefresh!(context, completer);
    } else {
      completer.complete(RefreshingStatus.complete);
    }

    switch (await completer.future) {
      case RefreshingStatus.complete:
        _refreshController.refreshCompleted();
        _hapticFeedback(HapticFeedbackManager.success);
        break;
      case RefreshingStatus.failed:
        _refreshController.refreshFailed();
        _hapticFeedback(HapticFeedbackManager.error);
        break;
    }
  }

  Future<void> _onLoad() async {
    final Completer<LoadingStatus> completer = Completer<LoadingStatus>();

    if (widget.onLoad != null) {
      widget.onLoad!(context, completer);
    } else {
      completer.complete(LoadingStatus.complete);
    }

    switch (await completer.future) {
      case LoadingStatus.complete:
        _refreshController.loadComplete();
        _hapticFeedback(HapticFeedbackManager.success);
        break;
      case LoadingStatus.failed:
        _refreshController.loadFailed();
        _hapticFeedback(HapticFeedbackManager.error);
        break;
      case LoadingStatus.noData:
        _hapticFeedback(HapticFeedbackManager.mediumImpact);
        _refreshController.loadNoData();
        break;
    }
  }

  Future<void> _hapticFeedback(Future<void> Function() feedback) async {
    return Future.delayed(_hapticFeedbackDelay, feedback);
  }
}
