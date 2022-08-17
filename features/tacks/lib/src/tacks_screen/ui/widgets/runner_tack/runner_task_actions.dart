import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

import 'package:tacks/src/tacks_screen/bloc/tacks_bloc.dart';

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
    final String labelKey;
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
        labelKey = 'tacksScreen.beginTackButton';
        icon = AppIconsTheme.taskComplete;
        break;
      case TackStatus.inProgress:
        labelKey = 'general.track';
        icon = null;
        break;
      case TackStatus.pendingReview:
        labelKey = 'tacksScreen.pendingReview';
        icon = AppIconsTheme.taskComplete;
        break;
      default:
        return const SizedBox.shrink();
    }

    return Row(
      children: <Widget>[
        AppCircleAvatarWidget(runnerTack.tack.group.imageUrl),
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

  void _onCancelButtonPressed(BuildContext context) {
    BlocProvider.of<TacksBloc>(context)
        .add(CancelTackOffer(runnerTack: runnerTack));
  }
}
