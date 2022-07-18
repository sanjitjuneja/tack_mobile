library tacker_tack;

import '../../user_model.dart';

part 'tacker_tack_status.dart';

class TackerTack {
  final String name;
  final double fee;
  final TackerTackStatus status;
  final Duration estimatedTime;
  final DateTime? completeTime;
  final UserModel creator;

  const TackerTack({
    required this.name,
    required this.fee,
    required this.status,
    required this.estimatedTime,
    required this.completeTime,
    required this.creator,
  });
}
