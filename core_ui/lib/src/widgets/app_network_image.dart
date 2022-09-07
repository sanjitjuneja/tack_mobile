import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../theme/app_theme.dart';

class AppNetworkImageWidget extends StatelessWidget {
  static const Duration _fadeInDuration = Duration(milliseconds: 300);
  static const Duration _fadeOutDuration = Duration(milliseconds: 500);

  final String? url;

  /// By default used [AppIconsTheme.tack] icon, if null provided in constructor
  /// backgroundColor will be used instead.
  final AppIcon? placeholderIcon;
  final Color? backgroundColor;
  final double diameter;
  final bool isShadowBorder;
  final BoxShape boxShape;
  final BoxFit boxFit;

  const AppNetworkImageWidget(
    this.url, {
    super.key,
    this.placeholderIcon = AppIconsTheme.tack,
    this.backgroundColor,
    this.diameter = 45.0,
    this.isShadowBorder = true,
    this.boxShape = BoxShape.circle,
    this.boxFit = BoxFit.cover,
  });

  Color get _backgroundColor => backgroundColor ?? AppTheme.transparentColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: boxShape,
        border: isShadowBorder
            ? Border.all(
                color: _backgroundColor,
                width: 2,
              )
            : null,
        color: isShadowBorder ? _backgroundColor : AppTheme.transparentColor,
      ),
      clipBehavior: Clip.hardEdge,
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
                  placeholderIcon?.call() ??
                  ColoredBox(color: _backgroundColor),
              errorWidget: (_, __, ___) =>
                  placeholderIcon?.call() ??
                  ColoredBox(color: _backgroundColor),
            )
          : placeholderIcon?.call() ?? AppIconsTheme.tack(),
    );
  }
}
