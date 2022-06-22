import 'package:domain/models/tack_list_model.dart';

final TackListModel examplePrivateTack = TackListModel(
  title: 'Computer Delivery (Dorm - > On-Campus bldg)',
  price: 23.50,
  rating: 4.99,
  imageUrl: '',
  reviewsCount: 46,
  primaryDelay: '1 hour',
  chanelName: 'Dorm Group',
  tackerName: 'Alan Cooper',
);

List<TackListModel> getPrivatTacks() {
  final List<TackListModel> tacks = [];
  for (int index = 0; index < 7; index++) {
    tacks.add(examplePrivateTack);
  }

  return tacks;
}
