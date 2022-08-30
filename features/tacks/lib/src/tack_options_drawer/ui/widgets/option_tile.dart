import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/widgets.dart';

class OptionTile extends StatelessWidget {
  final String titleKey;
  final AppIcon icon;
  final void Function(BuildContext) onTap;

  const OptionTile({
    super.key,
    required this.titleKey,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OpacityOnTapContainer(
      onTap: () => onTap(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        child: Row(
          children: <Widget>[
            icon(color: AppTheme.textPrimaryColor),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                FlutterI18n.translate(context, titleKey),
                style: AppTextTheme.manrope16Bold
                    .copyWith(color: AppTheme.textPrimaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
