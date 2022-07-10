part of app_theme;

class AppIcon {
  static const String _packageName = 'core_ui';

  final String iconKey;

  AppIcon(
      this.iconKey,
      );

  ImageIcon call({
    Color? color,
    double? size,
  }) {
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