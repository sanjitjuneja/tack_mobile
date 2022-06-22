import 'package:domain/domain.dart';

final CreateTackModel createUserTackExample = CreateTackModel(
  price: 15,
  time: '1 hour',
  isSavedTack: true,
  status: 'Auto Accept',
  description: 'Come make my bed before the end of the day. '
      'It does not have to be perfect, but make it look......',
  tackTitle: 'Clean My Room, Make My Bed',
);

final CreateTackModel createTackExample = CreateTackModel(
  price: 15,
  time: '1 hour',
  isSavedTack: false,
  status: 'Auto Accept',
  description: 'Come make my bed before the end of the day. '
      'It does not have to be perfect, but make it look......',
  tackTitle: 'Clean My Room, Make My Bed',
);

List<CreateTackModel> getCreateTackList() {
  final List<CreateTackModel> tacks = <CreateTackModel>[];
  for (int index = 0; index < 6; index++) {
    tacks.add(createTackExample);
    tacks.add(createUserTackExample);
  }
  return tacks;
}
