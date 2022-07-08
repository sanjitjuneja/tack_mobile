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

  const AppDivider({

    super.key,
    this.axis = Axis.horizontal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.dividerColor,
      height: axis == Axis.vertical ? null : 1,
      width: axis == Axis.horizontal ? null : 1,
    );
  }
}
