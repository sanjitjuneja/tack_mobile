import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:tacks/src/bloc/tacks_bloc.dart';

class RunnerTackActions extends StatelessWidget {
  final RunnerTack runnerTack;

  const RunnerTackActions({
    super.key,
    required this.runnerTack,
  });

  @override
  Widget build(BuildContext context) {
    switch (runnerTack.tack.status) {
      case TackStatus.pendingAccept:
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
                      .add(CancelTackOffer(tack: runnerTack.tack));
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: AppButton(
                labelWidget: RichText(
                  text: TextSpan(
                    children: <InlineSpan>[
                      TextSpan(
                        text: FlutterI18n.translate(
                          context,
                          'tacksScreen.offerExpiresIn',
                        ),
                        style: AppTextTheme.manrope14Medium.copyWith(
                          color: AppTheme.buttonInterfacePrimaryColor,
                        ),
                      ),
                      const TextSpan(text: ': '),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: TimeLeftWidget(
                          tillTime: runnerTack.offer!.expiredAt,
                          builder: (_, String content) {
                            return SizedBox(
                              width: 40,
                              child: Text(
                                content,
                                style: AppTextTheme.manrope14Medium.copyWith(
                                  color: AppTheme.buttonInterfacePrimaryColor,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      case TackStatus.pendingStart:
        return AppButton(
          labelKey: 'tacksScreen.beginTackButton',
          icon: AppIconsTheme.taskComplete,
        );
      case TackStatus.inProgress:
        return AppButton(
          labelKey: 'general.track',
        );
      case TackStatus.pendingReview:
        return AppButton(
          labelKey: 'tacksScreen.pendingReview',
          icon: AppIconsTheme.taskComplete,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
