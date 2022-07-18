import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:tacks/src/bloc/tacks_bloc.dart';
import 'package:tacks/src/tacks_screen/ui/widgets/runner_tack/time_counter_widget.dart';

class RunnerTackActions extends StatelessWidget {
  final RunnerTack tack;

  const RunnerTackActions({
    super.key,
    required this.tack,
  });

  @override
  Widget build(BuildContext context) {
    switch (tack.status) {
      case RunnerTackStatus.pendingAccept:
        return Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: AppButton(
                labelKey: 'tacksScreen.cancelOfferButton',
                type: ButtonType.secondary,
                withShadow: false,
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                onTap: () {
                  BlocProvider.of<TacksBloc>(context)
                      .add(CancelTackOffer(name: tack.name));
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: TimeCounterWidget(builder: (_) {
                final DateTime now = DateTime.now();
                final Duration left = tack.expireAt.difference(now);

                final String content =
                    DurationUtility.durationFormatTime(left, withHours: false);
                return AppButton(
                  labelKey: FlutterI18n.translate(
                    context,
                    'tacksScreen.offerExpiresIn',
                    translationParams: <String, String>{'time': content},
                  ),
                );
              }),
            ),
          ],
        );
      case RunnerTackStatus.pendingStart:
        return AppButton(
          labelKey: 'tacksScreen.beginTackButton',
          icon: AppIconsTheme.edit,
        );
      case RunnerTackStatus.inProgress:
        return AppButton(
          labelKey: 'general.track',
        );
      case RunnerTackStatus.pendingReview:
        return AppButton(
          labelKey: 'tacksScreen.pendingReview',
          icon: AppIconsTheme.edit,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
