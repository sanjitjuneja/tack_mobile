import 'package:core_ui/src/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';

enum WidgetShadowType {
  none,
  light,
  heavy;

  List<BoxShadow>? get shadow {
    switch (this) {
      case WidgetShadowType.none:
        return null;
      case WidgetShadowType.light:
        return <BoxShadow>[
          BoxShadow(
            color: AppTheme.lightShadowColor,
            offset: const Offset(0, 2),
            blurRadius: 2,
          ),
        ];
      case WidgetShadowType.heavy:
        return <BoxShadow>[
          BoxShadow(
            color: AppTheme.shadowColor,
            offset: const Offset(0, 4),
            blurRadius: 4,
          ),
        ];
    }
  }
}
