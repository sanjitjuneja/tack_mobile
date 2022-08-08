import 'package:domain/domain.dart';

final List<Tack> tacks = List<Tack>.generate(
  10,
  (int index) => Tack(
    id: 0,
    title: 'Pick Up My Clothes from Dry Cleaning',
    price: 15.0,
    description:
        'Pick up my dry cleaning and deliver to 31 Pascal Dr in Austin, TX 78705. We will meet you.',
    estimatedTime: const Duration(minutes: 15),
    allowCounterOffers: index % 2 == 0,
    status: TackStatus.created,
    tacker: const TackUser(
      id: 0,
      firstName: 'Alan',
      lastName: 'Cooper',
      rating: 2.5,
      tacksComplete: 120,
    ),
    runner: null,
    group: const Group(
      id: 0,
      ownerId: 0,
      name: 'Callaway Group',
      description: '',
      imageUrl: '',
      isPublic: true,
    ),
    completionMessage: null,
    completionTime: null,
  ),
);
