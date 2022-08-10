part of app_list_view_with_refresh;

class _RefreshHeader extends StatelessWidget {
  const _RefreshHeader();

  @override
  Widget build(BuildContext context) {
    return CustomHeader(
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
    );
  }
}
