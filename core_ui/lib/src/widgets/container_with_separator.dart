import 'package:core_ui/src/theme/app_theme.dart';
import 'package:core_ui/src/widgets/app_divider.dart';
import 'package:core_ui/src/helpers/widget_shadow_type.dart';
import 'package:flutter/material.dart';

class ContainerWithSeparator extends StatelessWidget {
  final Widget header;
  final Widget footer;
  final WidgetShadowType shadowType;
  final Color backgroundColor;
  final EdgeInsets padding;
  final EdgeInsets dividerPadding;

  ContainerWithSeparator({
    super.key,
    required this.header,
    required this.footer,
    WidgetShadowType? shadowType,
    Color? backgroundColor,
    EdgeInsets? padding,
    EdgeInsets? dividerPadding,
  })  : shadowType = shadowType ?? WidgetShadowType.heavy,
        backgroundColor = backgroundColor ?? AppTheme.primaryColor,
        padding = padding ??
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        dividerPadding =
            dividerPadding ?? const EdgeInsets.only(top: 16.0, bottom: 12.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: shadowType.shadow,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: padding.top),
          Padding(
            padding: EdgeInsets.only(
              left: padding.left,
              right: padding.right,
            ),
            child: header,
          ),
          SizedBox(height: dividerPadding.top),
          Padding(
            padding: EdgeInsets.only(
              left: dividerPadding.left,
              right: dividerPadding.right,
            ),
            child: const AppDivider(),
          ),
          SizedBox(height: dividerPadding.bottom),
          Padding(
            padding: EdgeInsets.only(
              left: padding.left,
              right: padding.right,
            ),
            child: footer,
          ),
          SizedBox(height: padding.bottom),
        ],
      ),
    );
  }
}
