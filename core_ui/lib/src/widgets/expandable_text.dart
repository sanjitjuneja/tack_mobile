import 'package:core/core.dart';
import 'package:core_ui/src/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';

import 'package:expandable_text/expandable_text.dart' as expand_text;

class ExpandableText extends StatelessWidget {
  static const Duration _expandDuration = Duration(milliseconds: 350);

  final String text;
  final TextStyle? style;

  const ExpandableText({
    super.key,
    required this.text,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return expand_text.ExpandableText(
      text,
      expandText: FlutterI18n.translate(context, 'general.more'),
      collapseText: FlutterI18n.translate(context, 'general.less'),
      textAlign: TextAlign.start,
      style: style,
      maxLines: 1,
      animation: true,
      animationDuration: _expandDuration,
      animationCurve: Curves.easeInOut,
      linkColor: AppTheme.textSecondaryColor,
    );
  }
}
