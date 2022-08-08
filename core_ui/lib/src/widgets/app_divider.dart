import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

/// To use [AppDivider] as vertical divider - [IntrinsicHeight] is needed.
///
/// IntrinsicHeight(
///        child: Row(
///          children: <Widget>[
///            ...,
///            const AppDivider(axis: Axis.vertical),
///            ...,
///          ],
///        ),
///      );
///

class AppDivider extends StatelessWidget {
  final Axis axis;
  final double? width;
  final double? height;

  const AppDivider({
    super.key,
    this.axis = Axis.horizontal,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.dividerColor,
      height: axis == Axis.vertical ? height : height ?? 1,
      width: axis == Axis.horizontal ? width : width ?? 1,
    );
  }
}
