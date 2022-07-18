library runner_tack;

import '../../user_model.dart';

part 'runner_tack_counter_offer.dart';
part 'runner_tack_status.dart';

class RunnerTack {
  final String name;
  final double fee;
  final RunnerTackStatus status;
  final Duration estimatedTime;
  final Duration? availableTime;
  final DateTime expireAt;
  final UserModel creator;
  final RunnerTackCounterOffer? counterOffer;

  const RunnerTack({
    required this.name,
    required this.fee,
    required this.status,
    required this.estimatedTime,
    required this.availableTime,
    required this.expireAt,
    required this.creator,
    required this.counterOffer,
  });
}
