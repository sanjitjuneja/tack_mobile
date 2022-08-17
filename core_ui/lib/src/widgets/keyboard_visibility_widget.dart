import 'package:flutter/cupertino.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

// TODO: rename.
class KeyboardVisibilityWidget extends StatelessWidget {
  static const Duration _paddingDuration = Duration(milliseconds: 200);
  static const Duration _opacityDuration = Duration(milliseconds: 150);

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
          duration: _paddingDuration,
          child: AnimatedCrossFade(
            crossFadeState: isKeyboardVisible
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: _opacityDuration,
            firstChild: child,
            secondChild: const SizedBox(width: double.infinity),
          ),
        );
      },
    );
  }
}
