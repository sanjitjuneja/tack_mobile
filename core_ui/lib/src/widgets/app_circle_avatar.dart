import 'package:core/core.dart';
import 'package:core_ui/src/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';

import 'package:cached_network_image/cached_network_image.dart';

class AppCircleAvatarWidget extends StatelessWidget {
  static const Duration _fadeInDuration = Duration(milliseconds: 300);
  static const Duration _fadeOutDuration = Duration(milliseconds: 500);

  final String? url;
  final AppIcon? placeholderIcon;
  final double diameter;
  final bool isShadowBorder;

  const AppCircleAvatarWidget(
    this.url, {
    super.key,
    this.placeholderIcon,
    this.diameter = 45.0,
    this.isShadowBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: isShadowBorder
            ? Border.all(
                color: AppTheme.primaryColor,
                width: 2,
              )
            : null,
        color: AppTheme.primaryColor,
      ),
      child: UrlManager.isValidUrl(url)
          ? CachedNetworkImage(
              fadeInDuration: _fadeInDuration,
              fadeOutDuration: _fadeOutDuration,
              imageUrl: url!,
              imageBuilder: (_, ImageProvider<Object> imageProvider) {
                return Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              placeholder: (_, __) =>
                  placeholderIcon?.call() ?? AppIconsTheme.tack(),
              errorWidget: (_, __, ___) =>
                  placeholderIcon?.call() ?? AppIconsTheme.tack(),
            )
          : placeholderIcon?.call() ?? AppIconsTheme.tack(),
    );
  }
}
