import 'package:flutter/cupertino.dart';

import 'overlay_entry_widget.dart';

class KeyboardOverlayWidget extends StatefulWidget {
  final Widget child;
  final FocusNode? focusNode;
  final bool isEnabled;

  const KeyboardOverlayWidget({
    super.key,
    required this.child,
    this.focusNode,
    this.isEnabled = true,
  });

  @override
  State<StatefulWidget> createState() => _KeyboardOverlayWidgetState();
}

class _KeyboardOverlayWidgetState extends State<KeyboardOverlayWidget> {
  OverlayEntry? _overlayEntry;

  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();

    focusNode = widget.focusNode ?? FocusScope.of(context);

    focusNode.addListener(() {
      bool hasFocus = focusNode.hasFocus;
      if (hasFocus) {
        if (widget.isEnabled) showOverlay(context);
      } else {
        if (widget.isEnabled) removeOverlay();
      }
    });
  }

  void showOverlay(BuildContext context) {
    if (_overlayEntry != null) return;

    OverlayState? overlayState = Overlay.of(context);

    _overlayEntry = OverlayEntry(
      builder: (_) => const OverlayEntryWidget(),
    );

    overlayState?.insert(_overlayEntry!);
  }

  void removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    _overlayEntry?.remove();

    super.dispose();
  }
}
