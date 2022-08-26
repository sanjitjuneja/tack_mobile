import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

class AddPaymentMethodTile extends StatelessWidget {
  final AppIcon leadingIcon;
  final String title;
  final VoidCallback onTap;

  const AddPaymentMethodTile({
    Key? key,
    required this.leadingIcon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 34,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppTheme.textFieldSecondaryBackgroundColor,
        ),
        child: Row(
          children: <Widget>[
            leadingIcon(size: 35),
            const SizedBox(width: 26),
            Text(
              title,
              style: AppTextTheme.poppins18Medium,
            ),
            const Spacer(),
            AppIconsTheme.chevronRightRounded(size: 35),
          ],
        ),
      ),
    );
  }
}
