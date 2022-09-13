import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:home/home.dart';
import 'package:navigation/navigation.dart';

import '../bloc/create_tack_bloc.dart';
import 'widgets/group_popular_tacks_widget.dart';
import 'widgets/nearby_popular_tacks_widget.dart';

class CreateTackForm extends StatelessWidget {
  const CreateTackForm({super.key});

  @override
  Widget build(BuildContext context) {
    final TabController? tabController = AppRouter.of(context)
        .navigationTabState
        .tabControllerForTab(HomeScreenTab.add);

    return BlocBuilder<CreateTackBloc, CreateTackState>(
      builder: (_, CreateTackState state) {
        return PageContainerWithAddButton(
          onAddButtonPressed: _onAddButtonPressed,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const PageHeaderWidget(
                descriptionKey: 'createTackScreen.description',
              ),
              const SizedBox(height: 17),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45.0),
                child: AppSegmentController(
                  controller: tabController,
                  tabs: <int, String>{
                    0: FlutterI18n.translate(
                      context,
                      'createTackScreen.tabs.first',
                    ),
                    1: FlutterI18n.translate(
                      context,
                      'createTackScreen.tabs.second',
                    ),
                  },
                ),
              ),
              const SizedBox(height: 5),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: const <Widget>[
                    NearbyPopularTacksWidget(),
                    GroupPopularTacksWidget(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onAddButtonPressed(BuildContext context) {
    BlocProvider.of<CreateTackBloc>(context).add(const CreateTackAction());
  }
}
