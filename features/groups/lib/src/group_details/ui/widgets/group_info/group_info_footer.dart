import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

class GroupInfoFooter extends StatelessWidget {
  final Group group;

  const GroupInfoFooter({
    super.key,
    required this.group,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      group.description,
      style: AppTextTheme.manrope14Regular
          .copyWith(color: AppTheme.textPrimaryColor),
    );
  }
}
