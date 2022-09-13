import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import '../../bloc/tacks_bloc.dart';
import 'tacker_tack/tacker_tack_widget.dart';

class TackerTacksWidget extends StatelessWidget {
  const TackerTacksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          FlutterI18n.translate(
            context,
            'tacksScreen.tacker.subtitle',
          ),
          style: AppTextTheme.manrope13Medium
              .copyWith(color: AppTheme.textHeavyHintColor),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: BlocBuilder<TacksBloc, TacksState>(
            builder: (_, TacksState state) {
              return AppListViewWithRefresh(
                enableRefresh: true,
                enableLoad: false,
                isLoading: state.tackerTacksData.isLoading,
                hasData: state.tackerTacksData.hasData,
                emptyWidget: EmptyWidget(
                  svgIcon: AppIconsTheme.tacksList,
                  descriptionKey: 'tacksScreen.empty.tackerTacks.description',
                  buttonLabelKey: 'tacksScreen.empty.tackerTacks.buttonLabel',
                  onButtonTap: () => _onEmptyStateButtonTap(context),
                ),
                onRefresh: _onRefreshAction,
                itemCount: state.tackerTacksData.results.length,
                itemBuilder: (_, int index) {
                  return TackerTackWidget(
                    tack: state.tackerTacksData.results[index],
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _onEmptyStateButtonTap(BuildContext context) {
    BlocProvider.of<TacksBloc>(context).add(const MoveToAddTab());
  }

  void _onRefreshAction(
    BuildContext context,
    Completer<RefreshingStatus> completer,
  ) {
    BlocProvider.of<TacksBloc>(context)
        .add(RefreshTackerTacks(completer: completer));
  }
}
