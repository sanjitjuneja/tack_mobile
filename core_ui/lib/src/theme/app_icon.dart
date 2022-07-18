part of app_theme;

class AppIcon {
  static const String _packageName = 'core_ui';

  final String iconKey;

  AppIcon(
    this.iconKey,
  );

  SvgPicture svg({
    Color? color,
    double? size,
    BoxFit? fit,
  }) {
    // TODO: refactor.
    assert(iconKey.contains('svg'));

    return SvgPicture.asset(
      iconKey,
      package: _packageName,
      color: color,
      height: size,
      width: size,
      fit: fit ?? BoxFit.contain,
    );
  }

  ImageIcon call({
    Color? color,
    double? size,
  }) {
    // TODO: refactor.
    assert(!iconKey.contains('svg'));

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
