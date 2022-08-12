import 'package:domain/domain.dart';

class GroupData {
  final Group? group;
  final bool isRequired;

  /// Used for Business Logic
  bool get isValid => isRequired ? group != null : true;

  bool get hasData => group != null;

  bool isDataChanged(int? oldGroupId) {
    return group?.id != oldGroupId;
  }

  const GroupData({
    required this.isRequired,
    this.group,
  });

  GroupData copyWith({
    Group? group,
  }) {
    return GroupData(
      group: group ?? this.group,
      isRequired: isRequired,
    );
  }

  GroupData empty() {
    return GroupData(
      group: null,
      isRequired: isRequired,
    );
  }
}
