import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

class InviteMembersButton extends StatelessWidget {
  final AppIcon leading;
  final AppIcon trailing;
  final String labelKey;
  final Color backgroundColor;
  final Color interfaceColor;
  final VoidCallback onTap;
  final String? content;

  const InviteMembersButton({
    super.key,
    required this.leading,
    required this.trailing,
    required this.labelKey,
    required this.backgroundColor,
    required this.interfaceColor,
    required this.onTap,
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    return OpacityOnTapContainer(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 14.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: <Widget>[
            leading(color: interfaceColor),
            const SizedBox(width: 13),
            Text(
              FlutterI18n.translate(context, labelKey),
              style:
                  AppTextTheme.manrope16Medium.copyWith(color: interfaceColor),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: content != null
                  ? Text(
                      content!.toElliptical,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextTheme.manrope14SemiBold
                          .copyWith(color: AppTheme.textHintColor),
                    )
                  : const SizedBox.shrink(),
            ),
            const SizedBox(width: 8),
            trailing(color: interfaceColor),
          ],
        ),
      ),
    );
  }
}
