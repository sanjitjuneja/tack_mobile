import 'package:core/core.dart';
import 'package:core_ui/src/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';

import 'package:expandable_text/expandable_text.dart' as expand_text;

class ExpandableText extends StatelessWidget {
  final String text;

  const ExpandableText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return expand_text.ExpandableText(
      text,
      expandText: FlutterI18n.translate(context, 'general.more'),
      collapseText: FlutterI18n.translate(context, 'general.less'),
      textAlign: TextAlign.start,
      style: AppTextTheme.manrope14Medium.copyWith(height: 1.5),
      maxLines: 1,
      animation: true,
      animationDuration: const Duration(milliseconds: 500),
      animationCurve: Curves.easeInOut,
      linkColor: AppTheme.textSecondaryColor,
    );
  }
}
