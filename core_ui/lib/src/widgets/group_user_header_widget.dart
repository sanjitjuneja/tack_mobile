import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

class GroupUserHeaderWidget extends StatelessWidget {
  final Group group;
  final UserModel user;
  final VoidCallback? onTap;

  const GroupUserHeaderWidget({
    super.key,
    required this.group,
    required this.user,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6.0),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap,
        child: Row(
          children: <Widget>[
            Container(
              width: 45,
              height: 45,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.shadowColor,
              ),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  user.name,
                  style: AppTextTheme.manrope18Regular
                      .copyWith(color: AppTheme.textPrimaryColor),
                ),
                Text(
                  group.name,
                  style: AppTextTheme.manrope11Regular
                      .copyWith(color: AppTheme.texHintColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
