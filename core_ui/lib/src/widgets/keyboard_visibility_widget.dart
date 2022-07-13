import 'package:flutter/cupertino.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

// TODO: rename.
class KeyboardVisibilityWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const KeyboardVisibilityWidget({
    super.key,
    required this.child,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (_, bool isKeyboardVisible) {
        return AnimatedPadding(
          padding: isKeyboardVisible ? padding.copyWith(bottom: 0) : padding,
          duration: const Duration(milliseconds: 150),
          child: AnimatedCrossFade(
            crossFadeState: isKeyboardVisible
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
            firstChild: child,
            secondChild: const SizedBox(width: double.infinity),
          ),
        );
      },
    );
  }
}
