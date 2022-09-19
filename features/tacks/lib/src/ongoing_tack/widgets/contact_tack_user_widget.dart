import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

class ContactTackUserWidget extends StatelessWidget {
  final bool isLoading;
  final bool hasData;
  final void Function(BuildContext) onChatPressed;
  final void Function(BuildContext) onCallPressed;

  const ContactTackUserWidget({
    super.key,
    required this.isLoading,
    required this.hasData,
    required this.onChatPressed,
    required this.onCallPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: AppProgressIndicator(
          backgroundColor: AppTheme.transparentColor,
          indicatorColor: AppTheme.progressInterfaceLightColor,
          indicatorSize: ProgressIndicatorSize.small,
          expand: false,
        ),
      );
    } else if (hasData) {
      return Row(
        children: <Widget>[
          OpacityOnTapContainer(
            onTap: () => onChatPressed(context),
            withFeedback: true,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: AppIconsTheme.message(
                color: AppTheme.iconSecondaryColor,
              ),
            ),
          ),
          const SizedBox(width: 8),
          OpacityOnTapContainer(
            onTap: () => onCallPressed(context),
            withFeedback: true,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: AppIconsTheme.phone(
                color: AppTheme.iconSecondaryColor,
              ),
            ),
          ),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
