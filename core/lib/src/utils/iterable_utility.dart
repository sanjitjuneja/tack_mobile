extension IterableFirstOrNull<T> on Iterable<T> {
  T? get firstOrNull => isNotEmpty ? first : null;
}

extension IterableLastOrNull<T> on Iterable<T> {
  T? get lastOrNull => isNotEmpty ? last : null;
}
