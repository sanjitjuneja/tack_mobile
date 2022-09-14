import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

import '../../../bloc/tacks_bloc.dart';

class RunnerTackActions extends StatelessWidget {
  final RunnerTack runnerTack;
  final VoidCallback? onTap;

  const RunnerTackActions({
    super.key,
    required this.runnerTack,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final String labelKey =
        'tacksScreen.statusButtons.runner.${runnerTack.tack.status.name}';
    AppIcon? icon;

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
                onTap: () => _onCancelButtonPressed(context),
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
                          onExpire: (BuildContext context) =>
                              _onRunnerTackOfferExpired(context, runnerTack),
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
        icon = AppIconsTheme.edit;
        break;
      case TackStatus.inProgress:
        icon = AppIconsTheme.taskComplete;
        break;
      case TackStatus.pendingReview:
        icon = AppIconsTheme.clock;
        break;
      default:
        return const SizedBox.shrink();
    }

    return Row(
      children: <Widget>[
        AppNetworkImageWidget(
          runnerTack.tack.group.imageUrl,
          placeholderIcon: null,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            runnerTack.tack.group.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextTheme.manrope16Bold
                .copyWith(color: AppTheme.textHeavyHintColor),
          ),
        ),
        const SizedBox(width: 6),
        AppButton(
          labelKey: labelKey,
          icon: icon,
          constraints: const BoxConstraints(minWidth: 120),
          expanded: false,
          onTap: onTap,
        ),
      ],
    );
  }

  void _onRunnerTackOfferExpired(BuildContext context, RunnerTack runnerTack) {
    BlocProvider.of<TacksBloc>(context).add(
      RunnerTackOfferExpired(
        runnerTack: runnerTack,
      ),
    );
  }

  void _onCancelButtonPressed(BuildContext context) {
    BlocProvider.of<TacksBloc>(context)
        .add(CancelTackOffer(runnerTack: runnerTack));
  }
}
