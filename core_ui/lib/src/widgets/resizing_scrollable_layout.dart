import 'package:flutter/cupertino.dart';

class ResizingScrollableLayout extends StatelessWidget {
  final List<Widget> children;
  final ScrollPhysics? physics;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final EdgeInsets padding;

  const ResizingScrollableLayout({
    super.key,
    required this.children,
    this.physics,
    MainAxisAlignment? mainAxisAlignment,
    MainAxisSize? mainAxisSize,
    EdgeInsets? padding,
  })  : mainAxisAlignment = mainAxisAlignment ?? MainAxisAlignment.start,
        mainAxisSize = mainAxisSize ?? MainAxisSize.max,
        padding = padding ?? const EdgeInsets.symmetric(horizontal: 16);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints viewportConstraints) {
        return CupertinoScrollbar(
          child: SingleChildScrollView(
            physics: physics,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: mainAxisAlignment,
                  mainAxisSize: mainAxisSize,
                  children: children,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
