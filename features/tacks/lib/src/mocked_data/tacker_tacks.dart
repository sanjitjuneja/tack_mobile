import 'package:domain/domain.dart';
import 'package:home/home.dart';

List<Tack> tackerTacks = <Tack>[
  Tack(
    id: 1,
    title: 'Need Laudry and Dishes Done (Room 903)',
    price: 23.50,
    description:
        'Pick up my dry cleaning and deliver to 31 Pascal Dr in Austin, TX 78705. We will meet you.',
    estimatedTime: const Duration(minutes: 15),
    allowCounterOffers: true,
    status: TackStatus.pendingReview,
    tacker: tackCreatorUser,
    runner: tackRunnerUsers.first,
    completionMessage: null,
    completionTime: null,
  ),
  Tack(
    id: 2,
    title: 'Need Laudry and Dishes Done (Room 903)',
    price: 23.50,
    description:
        'Pick up my dry cleaning and deliver to 31 Pascal Dr in Austin, TX 78705. We will meet you.',
    estimatedTime: const Duration(minutes: 15),
    allowCounterOffers: true,
    status: TackStatus.inProgress,
    tacker: tackCreatorUser,
    runner: tackRunnerUsers.first,
    completionMessage: null,
    completionTime: null,
  ),
  Tack(
    id: 3,
    title: 'Need Someone to Re-string my Fender Strat',
    price: 40.00,
    description:
        'Pick up my dry cleaning and deliver to 31 Pascal Dr in Austin, TX 78705. We will meet you.',
    estimatedTime: const Duration(minutes: 15),
    allowCounterOffers: true,
    status: TackStatus.pendingStart,
    tacker: tackCreatorUser,
    runner: tackRunnerUsers.first,
    completionMessage: null,
    completionTime: null,
  ),
  const Tack(
    id: 3,
    title: 'Need Someone to Re-string my Fender Strat',
    price: 40.00,
    description:
        'Pick up my dry cleaning and deliver to 31 Pascal Dr in Austin, TX 78705. We will meet you.',
    estimatedTime: Duration(minutes: 15),
    allowCounterOffers: true,
    status: TackStatus.pendingAccept,
    tacker: tackCreatorUser,
    runner: null,
    completionMessage: null,
    completionTime: null,
  ),
  const Tack(
    id: 4,
    title: 'Laundry (Room 1320)',
    price: 35.00,
    description:
        'Pick up my dry cleaning and deliver to 31 Pascal Dr in Austin, TX 78705. We will meet you.',
    estimatedTime: Duration(minutes: 15),
    allowCounterOffers: true,
    status: TackStatus.created,
    tacker: tackCreatorUser,
    runner: null,
    completionMessage: null,
    completionTime: null,
  ),
];
