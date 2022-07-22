part of app_dialog;

enum ProgressIndicatorSize {
  small(20),
  medium(40),
  big(80);

  final double size;

  double get strokeWidth {
    switch (this) {
      case ProgressIndicatorSize.small:
        return 4;
      case ProgressIndicatorSize.medium:
        return 7;
      case ProgressIndicatorSize.big:
        return 11;
    }
  }

  const ProgressIndicatorSize(this.size);
}
