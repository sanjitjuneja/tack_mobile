import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

class RoundedListMarker extends StatelessWidget {
  final double radius;

  const RoundedListMarker({
    required this.radius,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius,
      width: radius,
      decoration: BoxDecoration(
        color: AppTheme.accentColor,
        shape: BoxShape.circle,
      ),
    );
  }
}
