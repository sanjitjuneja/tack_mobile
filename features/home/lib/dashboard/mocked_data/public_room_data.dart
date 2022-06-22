import 'package:domain/models/tack_list_model.dart';

final TackListModel examplePublicTack = TackListModel(
  title: 'Pick Up My Clothes from Dry Cleaning',
  price: 15.0,
  rating: 4.97,
  imageUrl: '',
  reviewsCount: 127,
  primaryDelay: '15 min',
  secondaryDelay: '23 min',
);

List<TackListModel> getPublicTacks() {
  final List<TackListModel> tacks = [];
  for (int index = 0; index < 5; index++) {
    tacks.add(examplePublicTack);
  }

  return tacks;
}


