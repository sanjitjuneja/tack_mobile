import 'package:domain/domain.dart';

const UserModel user = UserModel(
  name: 'Home Feed',
  imageUrl: '',
);

const TackUser tackCreatorUser = TackUser(
  id: 0,
  firstName: 'Alan',
  lastName: 'Cooper',
  rating: 5,
  tacksComplete: 125,
  contacts: TackUserContacts(phoneNumber: '+375296159325'),
);

const List<TackUser> tackRunnerUsers = <TackUser>[
  TackUser(
    id: 1,
    firstName: 'Edan',
    lastName: 'Bothman',
    rating: 5,
    tacksComplete: 125,
    contacts: TackUserContacts(phoneNumber: '+375296159325'),
  ),
  TackUser(
    id: 2,
    firstName: 'Julian',
    lastName: 'Gomez',
    rating: 5,
    tacksComplete: 125,
    contacts: TackUserContacts(phoneNumber: '+375296159325'),
  ),
];
