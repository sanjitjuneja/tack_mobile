import 'package:core_ui/src/utilities/keyboard_utility.dart';
import 'package:flutter/cupertino.dart';

class KeyboardDismissible extends StatelessWidget {
  final Widget child;

  const KeyboardDismissible({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => KeyboardUtility.hideKeyboard(context),
      child: child,
    );
  }
}
