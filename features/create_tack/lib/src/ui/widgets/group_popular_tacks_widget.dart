import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:home/home.dart';

import '../../bloc/create_tack_bloc.dart';
import 'template_tack/template_tack_tile.dart';

class GroupPopularTacksWidget extends StatelessWidget {
  const GroupPopularTacksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 10),
        Expanded(
          child: BlocBuilder<CreateTackBloc, CreateTackState>(
            builder: (_, CreateTackState state) {
              return AppListViewWithRefresh(
                enableRefresh: true,
                enableLoad: state.groupTacksState.canLoadMore,
                isLoading: state.groupTacksState.isLoading,
                hasData: state.groupTacksState.hasData,
                emptyWidget: BlocBuilder<GlobalBloc, GlobalState>(
                  builder: (_, GlobalState state) {
                    final String descriptionKey;
                    if (state.isGroupSelected) {
                      descriptionKey =
                          'createTackScreen.groupPopular.empty.description';
                    } else {
                      descriptionKey =
                          'createTackScreen.groupPopular.empty.noGroupSelectedDescription';
                    }

                    return EmptyWidget(
                      svgIcon: AppIconsTheme.tacksList,
                      descriptionKey: descriptionKey,
                    );
                  },
                ),
                onRefresh: _onRefreshAction,
                itemCount: state.groupTacksState.tacks.length,
                itemBuilder: (_, int index) {
                  return TemplateTackTile(
                    tack: state.groupTacksState.tacks[index],
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _onRefreshAction(
    BuildContext context,
    Completer<RefreshingStatus> completer,
  ) {
    BlocProvider.of<CreateTackBloc>(context)
        .add(RefreshGroupTacks(completer: completer));
  }
}
