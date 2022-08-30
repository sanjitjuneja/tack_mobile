import 'package:core/core.dart';
import 'package:core_ui/src/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';

import 'package:cached_network_image/cached_network_image.dart';

class AppNetworkImageWidget extends StatelessWidget {
  static const Duration _fadeInDuration = Duration(milliseconds: 300);
  static const Duration _fadeOutDuration = Duration(milliseconds: 500);

  final String? url;
  final AppIcon? placeholderIcon;
  final double diameter;
  final bool isShadowBorder;
  final BoxShape boxShape;
  final BoxFit boxFit;
  final Color? imageBackgroundColor;

  const AppNetworkImageWidget(
    this.url, {
    super.key,
    this.placeholderIcon,
    this.diameter = 45.0,
    this.isShadowBorder = true,
    this.boxShape = BoxShape.circle,
    this.boxFit = BoxFit.cover,
    this.imageBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: boxShape,
        border: isShadowBorder
            ? Border.all(
                color: AppTheme.primaryColor,
                width: 2,
              )
            : null,
        color: imageBackgroundColor ?? AppTheme.primaryColor,
      ),
      child: UrlManager.isValidUrl(url)
          ? CachedNetworkImage(
              fadeInDuration: _fadeInDuration,
              fadeOutDuration: _fadeOutDuration,
              imageUrl: url!,
              imageBuilder: (_, ImageProvider<Object> imageProvider) {
                return Container(
                  decoration: BoxDecoration(
                    shape: boxShape,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: boxFit,
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
