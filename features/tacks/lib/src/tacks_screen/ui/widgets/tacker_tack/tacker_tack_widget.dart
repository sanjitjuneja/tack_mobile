import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';
import 'package:tacks/src/ongoing_tack/ongoing_tacker_tack/ui/ongoing_tacker_tack_page.dart';
import 'package:tacks/src/tacks_screen/ui/widgets/tack_header_widget.dart';
import 'package:tacks/src/tacks_screen/ui/widgets/tacker_tack/tacker_tack_actions.dart';

class TackerTackWidget extends StatelessWidget {
  final Tack tack;

  const TackerTackWidget({
    super.key,
    required this.tack,
  });

  @override
  Widget build(BuildContext context) {
    return OpacityOnTapContainer(
      onTap: () => _onTap(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppTheme.shadowColor,
              offset: const Offset(0, 4),
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            TackHeaderWidget(
              tack: tack,
              isRunner: false,
            ),
            const SizedBox(height: 30),
            TackerTackActions(
              tack: tack,
              onTap: () => _onTap(context),
            ),
          ],
        ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    AppRouter.of(context).push(OngoingTackerTack.page(tack: tack));
  }
}
