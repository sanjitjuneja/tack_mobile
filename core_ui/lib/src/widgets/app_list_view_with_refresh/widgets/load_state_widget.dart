part of app_list_view_with_refresh;

class _LoadStateWidget extends StatelessWidget {
  final ProgressIndicatorSize indicatorSize;
  final Color? indicatorColor;

  const _LoadStateWidget({
    required this.indicatorSize,
    required this.indicatorColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppProgressIndicator(
        backgroundColor: AppTheme.transparentColor,
        indicatorSize: indicatorSize,
        indicatorColor: indicatorColor,
      ),
    );
  }
}
