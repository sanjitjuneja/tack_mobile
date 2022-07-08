part of group_drawer;

class SelectableGroup with AppSelectableItem, EquatableMixin {
  final Group group;

  @override
  String get title => group.title;

  @override
  String? get imagePath => group.imageUrl;

  const SelectableGroup(this.group);

  @override
  List<Object> get props => <Object>[group.id];

  @override
  String toString() {
    return '$runtimeType(group: $group)';
  }
}
