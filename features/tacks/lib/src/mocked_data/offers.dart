import 'package:domain/domain.dart';
import 'package:home/home.dart';

List<Offer> offers = <Offer>[
  Offer(
    id: 1,
    tackId: 1,
    runner: tackRunnerUsers.first,
    price: 0,
    type: OfferType.offer,
    isAccepted: false,
    createdAt: DateTime.now(),
    lifetime: const Duration(minutes: 13),
  ),
  Offer(
    id: 1,
    tackId: 1,
    runner: tackRunnerUsers.first,
    price: 20,
    type: OfferType.counterOffer,
    isAccepted: false,
    createdAt: DateTime.now(),
    lifetime: const Duration(minutes: 13),
  ),
  Offer(
    id: 1,
    tackId: 1,
    runner: tackRunnerUsers.last,
    price: 20,
    type: OfferType.counterOffer,
    isAccepted: false,
    createdAt: DateTime.now(),
    lifetime: const Duration(minutes: 7),
  ),
];
