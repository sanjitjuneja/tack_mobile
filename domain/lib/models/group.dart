class Group {
  final int id;
  final String title;
  final String? imageUrl;

  const Group({
    required this.id,
    required this.title,
    this.imageUrl,
  });

  @override
  String toString() {
    return '$runtimeType(id: $id, '
        'title: $title, '
        'imageUrl: $imageUrl'
        ')';
  }
}
