class Group {
  final int id;
  final String name;
  final String? imageUrl;

  const Group({
    required this.id,
    required this.name,
    this.imageUrl,
  });

  @override
  String toString() {
    return '$runtimeType(id: $id, '
        'title: $name, '
        'imageUrl: $imageUrl'
        ')';
  }
}
