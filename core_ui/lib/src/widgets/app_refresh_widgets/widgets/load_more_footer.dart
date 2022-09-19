part of app_refresh_widgets;

class _LoadMoreFooter extends StatelessWidget {
  final Color? indicatorColor;
  final ProgressIndicatorSize indicatorSize;

  const _LoadMoreFooter({
    required this.indicatorColor,
    required this.indicatorSize,
  });

  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      loadStyle: LoadStyle.ShowWhenLoading,
      height: indicatorSize.size + indicatorSize.size / 4,
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
              indicatorSize: indicatorSize,
              indicatorColor: indicatorColor,
              expand: false,
            ),
          );
        }
      },
    );
  }
}
