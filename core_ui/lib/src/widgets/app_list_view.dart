import 'package:flutter/cupertino.dart';

class AppListView extends StatelessWidget {
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;

  const AppListView({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
    this.padding,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoScrollbar(
      child: ListView.separated(
        shrinkWrap: physics is NeverScrollableScrollPhysics,
        physics: physics,
        padding: padding ??
            const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 16.0,
            ),
        itemBuilder: itemBuilder,
        separatorBuilder: (_, __) => const SizedBox(height: 12.0),
        itemCount: itemCount,
      ),
    );
  }
}
