extension IterableLastOrNull<T> on Iterable<T> {
  T? get lastOrNull => isNotEmpty ? last : null;
}
