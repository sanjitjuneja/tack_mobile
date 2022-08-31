library finished_tack_tile;

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

import '../../../bloc/previous_tacks_bloc.dart';

part 'finished_tack_complete_info_widget.dart';

part 'finished_tack_header_widget.dart';

class FinishedTackTile extends StatelessWidget {
  final String tackName;
  final double tackPrice;
  final DateTime completedAt;
  final TackUser user;

  const FinishedTackTile({
    super.key,
    required this.tackName,
    required this.tackPrice,
    required this.completedAt,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return ContainerWithSeparator(
      padding: const EdgeInsets.only(
        top: 12,
        left: 16,
        right: 16,
        bottom: 16,
      ),
      header: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FinishedTackHeaderWidget(
            name: tackName,
            price: tackPrice,
          ),
          const SizedBox(height: 10),
          FinishedCompleteInfoWidget(
            completedAt: completedAt,
          ),
        ],
      ),
      footer: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  user.fullName,
                  style: AppTextTheme.manrope14SemiBold
                      .copyWith(color: AppTheme.textPrimaryColor),
                ),
                const SizedBox(height: 4),
                UserStatsWidget.fromTackUser(
                  tackUser: user,
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          OpacityOnTapContainer(
            onTap: () => _onMoreButtonPressed(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 2.0,
              ),
              child: AppIconsTheme.more(),
            ),
          ),
        ],
      ),
    );
  }

  void _onMoreButtonPressed(BuildContext context) {
    BlocProvider.of<PreviousTacksBloc>(context).add(const OpenOptions());
  }
}
