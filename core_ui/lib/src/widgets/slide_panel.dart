import 'package:flutter/material.dart';

import '../../core_ui.dart';

class SlidePanelWidget extends StatefulWidget {
  final AnimationController controller;
  final Widget child;

  const SlidePanelWidget({
    required this.child,
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  State<SlidePanelWidget> createState() => _SlidePanelWidgetState();
}

class _SlidePanelWidgetState extends State<SlidePanelWidget> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * widget.controller.value,
      decoration: BoxDecoration(
        color: AppTheme.positiveColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 14, bottom: 16),
              child: LifterWidget(),
            ),
            Opacity(
              opacity: _opacity(),
              child: widget.child,
            ),
          ],
        ),
      ),
    );
  }

  double _opacity() {
    double one = widget.controller.value + 0.6; // 0.6 - 1.6
    double two = one > 1 ? 1 - (one - 1) : one; //
    double three = two < 0.6 ? 0 : 1 - (1 - two) * 2.5;
    return widget.controller.value < 0.4 ? 1 : three;
  }
}
