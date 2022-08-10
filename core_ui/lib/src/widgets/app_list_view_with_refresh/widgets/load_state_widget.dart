part of app_list_view_with_refresh;

class _LoadStateWidget extends StatelessWidget {
  const _LoadStateWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppProgressIndicator(
        backgroundColor: AppTheme.transparentColor,
      ),
    );
  }
}
