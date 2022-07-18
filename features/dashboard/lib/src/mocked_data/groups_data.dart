import 'dart:math';

import 'package:domain/domain.dart';

List<Group> getGroups(int length) {
  return List.generate(
    length,
    (int index) {
      final int randomGroupNameIndex = Random().nextInt(groupNames.length);

      return Group(
        id: index,
        ownerId: index,
        name: groupNames[randomGroupNameIndex],
        description: '${groupNames[randomGroupNameIndex]} $index',
        imageUrl: '',
        isPublic: true,
      );
    },
  );
}

const List<String> groupNames = <String>[
  'Callaway Group',
  'History Class',
  'Texas Fiji PC’ 21',
];
