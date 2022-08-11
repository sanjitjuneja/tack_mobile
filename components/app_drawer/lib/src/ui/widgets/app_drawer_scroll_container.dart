import 'package:flutter/cupertino.dart';

class AppDrawerScrollContainer extends StatelessWidget {
  final List<Widget> children;

  const AppDrawerScrollContainer({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: CupertinoScrollbar(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SafeArea(
            top: false,
            child: Column(
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}
