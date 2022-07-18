import 'package:domain/domain.dart';
import 'package:home/home.dart';

const List<TackerTack> tackerTacks = <TackerTack>[
  TackerTack(
    name: 'Need Laudry and Dishes Done (Room 903)',
    fee: 23.50,
    status: TackerTackStatus.pendingReview,
    estimatedTime: Duration(minutes: 15),
    completeTime: null,
    creator: tackCreatorUser,
  ),
  TackerTack(
    name: 'Need Laudry and Dishes Done (Room 903)',
    fee: 23.50,
    status: TackerTackStatus.inProgress,
    estimatedTime: Duration(minutes: 15),
    completeTime: null,
    creator: tackCreatorUser,
  ),
  TackerTack(
    name: 'Need Laudry and Dishes Done (Room 903)',
    fee: 40.00,
    status: TackerTackStatus.pendingChoose,
    estimatedTime: Duration(minutes: 15),
    completeTime: null,
    creator: tackCreatorUser,
  ),
  TackerTack(
    name: 'Need Laudry and Dishes Done (Room 903)',
    fee: 35.00,
    status: TackerTackStatus.created,
    estimatedTime: Duration(minutes: 15),
    completeTime: null,
    creator: tackCreatorUser,
  ),
];
