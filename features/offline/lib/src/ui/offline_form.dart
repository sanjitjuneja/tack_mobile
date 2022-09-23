import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

class OfflineForm extends StatelessWidget {
  const OfflineForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EmptyWidget(
      svgIcon: AppIconsTheme.offline,
      iconColor: AppTheme.errorColor,
      titleKey: 'offlineScreen.title',
      descriptionKey: 'offlineScreen.description',
    );
  }
}
