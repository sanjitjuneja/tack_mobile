import 'package:flutter/cupertino.dart';

class AppScrollView extends StatelessWidget {
  final List<Widget> children;
  final CrossAxisAlignment? crossAxisAlignment;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;

  const AppScrollView({
    super.key,
    required this.children,
    this.crossAxisAlignment,
    this.padding,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoScrollbar(
      child: SingleChildScrollView(
        physics: physics,
        padding: padding ??
            const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 16.0,
            ),
        child: Column(
          crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}
