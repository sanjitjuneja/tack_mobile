import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

class PageHeaderWidget extends StatelessWidget {
  final String titleKey;
  final Group? group;
  final AppIcon? image;
  final String? subtitleKey;
  final VoidCallback? onTap;

  const PageHeaderWidget({
    super.key,
    required this.titleKey,
    this.group,
    this.image,
    this.subtitleKey,
    this.onTap,
  }) : assert(group != null || subtitleKey != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6.0),
      child: OpacityOnTapContainer(
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AppCircleAvatarWidget(
              group?.imageUrl,
              placeholderIcon: image,
            ),
            const SizedBox(width: 14),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  FlutterI18n.translate(context, titleKey),
                  style: AppTextTheme.manrope18Regular.copyWith(
                    color: AppTheme.textPrimaryColor,
                  ),
                ),
                Text(
                  group?.name ?? FlutterI18n.translate(context, subtitleKey!),
                  style: AppTextTheme.manrope11Regular.copyWith(
                    color: AppTheme.textHintColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}