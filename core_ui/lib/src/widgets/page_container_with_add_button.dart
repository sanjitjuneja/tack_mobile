import 'package:core_ui/src/theme/app_theme.dart';
import 'package:core_ui/src/widgets/app_button.dart';
import 'package:flutter/material.dart';

class PageContainerWithAddButton extends StatelessWidget {
  final Widget child;
  final void Function(BuildContext)? onAddButtonPressed;

  const PageContainerWithAddButton({
    super.key,
    required this.child,
    this.onAddButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.transparentColor,
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: AppButton(
        icon: AppIconsTheme.plus,
        iconSize: 28,
        withFeedback: true,
        expanded: false,
        shape: BoxShape.circle,
        onTap: () => onAddButtonPressed?.call(context),
      ),
      body: child,
    );
  }
}
