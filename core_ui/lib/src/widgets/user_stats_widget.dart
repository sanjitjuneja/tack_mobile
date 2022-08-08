import 'dart:ui' as ui;

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

class UserStatsWidget extends StatelessWidget {
  final double rating;
  final int tacksComplete;
  final Brightness brightness;

  Color get interfaceColor {
    switch (brightness) {
      case Brightness.dark:
        return AppTheme.textHintColor;
      case Brightness.light:
        return AppTheme.textBrightColor;
    }
  }

  const UserStatsWidget({
    super.key,
    required this.rating,
    required this.tacksComplete,
    this.brightness = Brightness.dark,
  });

  factory UserStatsWidget.fromUser({
    required User user,
  }) {
    return UserStatsWidget(
      rating: user.rating,
      tacksComplete: user.tacksAmount,
    );
  }

  factory UserStatsWidget.fromTackUser({
    required TackUser tackUser,
  }) {
    return UserStatsWidget(
      rating: tackUser.rating,
      tacksComplete: tackUser.tacksComplete,
    );
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: AppTextTheme.manrope13SemiBold.copyWith(color: interfaceColor),
        children: <InlineSpan>[
          WidgetSpan(
            alignment: ui.PlaceholderAlignment.middle,
            child: AppIconsTheme.star(size: 15),
          ),
          const WidgetSpan(child: SizedBox(width: 2)),
          TextSpan(
            text: rating.toStringAsFixed(2),
          ),
          const TextSpan(text: '\t\t|\t'),
          WidgetSpan(
            alignment: ui.PlaceholderAlignment.middle,
            child: AppIconsTheme.tack(size: 16),
          ),
          const WidgetSpan(child: SizedBox(width: 2)),
          TextSpan(
            text: FlutterI18n.plural(
              context,
              'general.tack',
              tacksComplete,
            ),
          ),
        ],
      ),
    );
  }
}
