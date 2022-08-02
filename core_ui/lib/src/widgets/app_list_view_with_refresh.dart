import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

enum LoadingStatus {
  complete,
  failed,
  noData,
}

enum RefreshingStatus {
  complete,
  failed,
}

typedef LoadCallback = void Function(BuildContext, Completer<LoadingStatus>);
typedef RefreshCallback = void Function(
    BuildContext, Completer<RefreshingStatus>);

class AppListViewWithRefresh extends StatefulWidget {
  final BuilderFunction itemBuilder;
  final int itemCount;
  final bool isLoading;
  final bool hasData;
  final Widget? emptyWidget;
  final ScrollPhysics? physics;
  final bool enableLoad;
  final bool enableRefresh;
  final LoadCallback? onLoad;
  final RefreshCallback? onRefresh;

  const AppListViewWithRefresh({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
    this.isLoading = false,
    this.hasData = true,
    this.emptyWidget,
    this.enableLoad = true,
    this.enableRefresh = true,
    this.onLoad,
    this.onRefresh,
    this.physics,
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

    return widget.enableLoad;
  }

  @override
  void initState() {
    _refreshController = RefreshController(initialRefresh: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoScrollbar(
      child: SmartRefresher(
        enablePullDown: enableRefresh,
        enablePullUp: enableLoad,
        header: CustomHeader(
          builder: (_, RefreshStatus? status) {
            if (status == RefreshStatus.completed) {
              return Center(
                child: Text(
                  FlutterI18n.translate(context, 'general.upToDate'),
                  style: AppTextTheme.manrope12Medium
                      .copyWith(color: AppTheme.textHintColor),
                ),
              );
            } else if (status == RefreshStatus.failed) {
              return Center(
                child: Text(
                  FlutterI18n.translate(context, 'general.updateFailed'),
                  style: AppTextTheme.manrope12Medium
                      .copyWith(color: AppTheme.textHintColor),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: AppProgressIndicator(
                  backgroundColor: AppTheme.transparentColor,
                  indicatorSize: ProgressIndicatorSize.medium,
                  expand: false,
                ),
              );
            }
          },
        ),
        footer: CustomFooter(
          loadStyle: LoadStyle.ShowWhenLoading,
          builder: (_, LoadStatus? status) {
            if (status == LoadStatus.failed) {
              return Center(
                child: Text(
                  FlutterI18n.translate(context, 'general.updateFailed'),
                  style: AppTextTheme.manrope12Medium
                      .copyWith(color: AppTheme.textHintColor),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppProgressIndicator(
                  backgroundColor: AppTheme.transparentColor,
                  indicatorSize: ProgressIndicatorSize.medium,
                  expand: false,
                ),
              );
            }
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoad,
        child: widget.isLoading
            ? Center(
                child: AppProgressIndicator(
                  backgroundColor: AppTheme.transparentColor,
                ),
              )
            : widget.hasData
                ? ListView.separated(
                    shrinkWrap: widget.physics is NeverScrollableScrollPhysics,
                    physics: widget.physics,
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                    itemBuilder: widget.itemBuilder,
                    separatorBuilder: (_, __) => const SizedBox(height: 12.0),
                    itemCount: widget.itemCount,
                  )
                : widget.emptyWidget ?? const SizedBox.shrink(),
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
