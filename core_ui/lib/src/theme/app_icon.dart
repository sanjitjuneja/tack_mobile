part of app_theme;

class AppIcon {
  static const String _packageName = 'core_ui';
  static const double _defaultIconSize = 24.0;

  final String iconKey;

  bool get isSVG => iconKey.contains('svg');

  AppIcon(
    this.iconKey,
  );

  SvgPicture svg({
    Color? color,
    double? size,
    BoxFit? fit,
  }) {
    // TODO: refactor.
    assert(isSVG);

    return SvgPicture.asset(
      iconKey,
      package: _packageName,
      color: color,
      height: size,
      width: size,
      fit: fit ?? BoxFit.contain,
    );
  }

  Widget call({
    Color? color,
    double size = _defaultIconSize,
  }) {
    // TODO: refactor.
    if (isSVG) {
      return SvgPicture.asset(
        iconKey,
        package: _packageName,
        color: color,
        height: size,
        width: size,
        fit: BoxFit.contain,
      );
    }

    return ImageIcon(
      AssetImage(
        iconKey,
        package: _packageName,
      ),
      color: color,
      size: size,
    );
  }
}
