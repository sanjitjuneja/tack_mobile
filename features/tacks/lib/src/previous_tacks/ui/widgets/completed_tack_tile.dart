import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

import 'finished_tack_tile/finished_tack_tile.dart';

class CompletedTackTile extends StatelessWidget {
  final Tack tack;

  const CompletedTackTile({
    super.key,
    required this.tack,
  });

  @override
  Widget build(BuildContext context) {
    return FinishedTackTile(
      tackName: tack.title,
      tackPrice: tack.price,
      completedAt: tack.completionTime!,
      user: tack.tacker,
    );
  }
}
