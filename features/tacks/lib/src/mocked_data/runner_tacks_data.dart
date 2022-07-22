import 'package:domain/domain.dart';
import 'package:home/home.dart';

List<RunnerTack> runnerTacks = <RunnerTack>[
  const RunnerTack(
    tack: Tack(
      id: 5,
      title: 'Pick Up My Clothes from Dry Cleaning',
      price: 15.00,
      description:
          'Pick up my dry cleaning and deliver to 31 Pascal Dr in Austin, TX 78705. We will meet you.',
      estimatedTime: Duration(minutes: 15),
      allowCounterOffers: true,
      status: TackStatus.pendingReview,
      tacker: tackCreatorUser,
      runner: null,
      completionMessage: null,
      completionTime: null,
    ),
    offer: null,
  ),
  const RunnerTack(
    tack: Tack(
      id: 6,
      title: 'Avalanche Party Set Up Crew',
      price: 15.00,
      description:
          'Pick up my dry cleaning and deliver to 31 Pascal Dr in Austin, TX 78705. We will meet you.',
      estimatedTime: Duration(hours: 1),
      allowCounterOffers: true,
      status: TackStatus.inProgress,
      tacker: tackCreatorUser,
      runner: null,
      completionMessage: null,
      completionTime: null,
    ),
    offer: null,
  ),
  const RunnerTack(
    tack: Tack(
      id: 7,
      title: 'Avalanche Party Set Up Crew',
      price: 15.00,
      description:
          'Pick up my dry cleaning and deliver to 31 Pascal Dr in Austin, TX 78705. We will meet you.',
      estimatedTime: Duration(hours: 1),
      allowCounterOffers: true,
      status: TackStatus.pendingStart,
      tacker: tackCreatorUser,
      runner: null,
      completionMessage: null,
      completionTime: null,
    ),
    offer: null,
  ),
  RunnerTack(
    tack: const Tack(
      id: 9,
      title: 'Need Laundry and Dishes Done (Room 903)',
      price: 15.00,
      description:
          'Pick up my dry cleaning and deliver to 31 Pascal Dr in Austin, TX 78705. We will meet you.',
      estimatedTime: Duration(hours: 1),
      allowCounterOffers: true,
      status: TackStatus.pendingAccept,
      tacker: tackCreatorUser,
      runner: null,
      completionMessage: null,
      completionTime: null,
    ),
    offer: Offer(
      id: 1,
      tackId: 9,
      runner: tackRunnerUsers.first,
      price: 15.00,
      type: OfferType.offer,
      isAccepted: true,
      createdAt: DateTime.now(),
      lifetime: const Duration(minutes: 8),
    ),
  ),
  RunnerTack(
    tack: const Tack(
      id: 9,
      title: 'Need Laundry and Dishes Done (Room 903)',
      price: 15.00,
      description:
          'Pick up my dry cleaning and deliver to 31 Pascal Dr in Austin, TX 78705. We will meet you.',
      estimatedTime: Duration(hours: 1),
      allowCounterOffers: true,
      status: TackStatus.pendingAccept,
      tacker: tackCreatorUser,
      runner: null,
      completionMessage: null,
      completionTime: null,
    ),
    offer: Offer(
      id: 1,
      tackId: 9,
      runner: tackRunnerUsers.first,
      price: 15.00,
      type: OfferType.offer,
      isAccepted: true,
      createdAt: DateTime.now(),
      lifetime: const Duration(minutes: 15),
    ),
  ),
];
