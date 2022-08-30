import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import 'widgets/customer_support_tile.dart';

class TackOptionsDrawerForm extends StatelessWidget {
  const TackOptionsDrawerForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 0,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            SizedBox(height: 12),
            DrawerAccessoryWidget(),
            SizedBox(height: 24),
            CustomerSupportTile(),
          ],
        ),
      ),
    );
  }
}
