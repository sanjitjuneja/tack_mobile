part of app_list_view_with_refresh;

class _LoadMoreFooter extends StatelessWidget {
  const _LoadMoreFooter();

  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      loadStyle: LoadStyle.ShowWhenLoading,
      height: 50,
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
    );
  }
}
