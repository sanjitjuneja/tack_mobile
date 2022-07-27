import 'dart:ui' as ui;

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

class UserStatsWidget extends StatelessWidget {
  final String name;
  final double rating;
  final int tacksComplete;

  const UserStatsWidget({
    super.key,
    required this.name,
    required this.rating,
    required this.tacksComplete,
  });

  factory UserStatsWidget.fromTackUser({
    required TackUser tackUser,
  }) {
    return UserStatsWidget(
      name: tackUser.fullName,
      rating: tackUser.rating,
      tacksComplete: tackUser.tacksComplete,
    );
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: AppTextTheme.manrope13SemiBold
            .copyWith(color: AppTheme.textHintColor),
        children: <InlineSpan>[
          WidgetSpan(
            alignment: ui.PlaceholderAlignment.middle,
            child: AppIconsTheme.star(size: 15),
          ),
          const WidgetSpan(child: SizedBox(width: 1)),
          TextSpan(text: '$rating'),
          const TextSpan(text: '\t\t|\t'),
          WidgetSpan(
            alignment: ui.PlaceholderAlignment.middle,
            child: AppIconsTheme.tack(size: 16),
          ),
          const WidgetSpan(child: SizedBox(width: 1)),
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
