import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

class TackButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const TackButton({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 56),
        padding: const EdgeInsets.symmetric(vertical: 22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(140),
          color: AppTheme.grassColor,
        ),
        child: Center(
          child: Text(
            title,
            maxLines: 1,
            style: AppTextTheme.manrope16SemiBold.copyWith(
              color: AppTheme.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
