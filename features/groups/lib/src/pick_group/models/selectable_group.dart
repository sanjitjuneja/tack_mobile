part of pick_group;

class _SelectableGroup with AppSelectableItem, EquatableMixin {
  final Group group;

  @override
  String get title => group.name;

  @override
  String? get imagePath => group.imageUrl;

  @override
  AppIcon? get placeholderIcon => null;

  const _SelectableGroup(this.group);

  @override
  List<Object> get props => <Object>[group.id];

  @override
  String toString() {
    return '$runtimeType(group: $group)';
  }
}
