part of pick_group;

class _PickGroupScreen extends StatelessWidget {
  final Group? selectedGroup;

  const _PickGroupScreen({
    required this.selectedGroup,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.secondaryBackgroundColor,
      navigationBar: AppNavigationBar(
        backgroundColor: AppTheme.secondaryBackgroundColor,
        withResult: true,
      ),
      child: SafeArea(
        child: _PickGroupForm(
          selectedGroup: selectedGroup,
        ),
      ),
    );
  }
}
