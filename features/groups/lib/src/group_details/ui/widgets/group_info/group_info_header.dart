import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

class GroupInfoHeader extends StatelessWidget {
  final Group group;

  const GroupInfoHeader({
    super.key,
    required this.group,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        AppNetworkImageWidget(group.imageUrl),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            group.name,
            maxLines: 2,
            style: AppTextTheme.manrope24SemiBold
                .copyWith(color: AppTheme.textPrimaryColor),
          ),
        ),
      ],
    );
  }
}
