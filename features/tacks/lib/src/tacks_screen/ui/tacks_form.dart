import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:home/home.dart';
import 'package:navigation/navigation.dart';

import 'widgets/runner_tacks_widget.dart';
import 'widgets/tacker_tacks_widget.dart';

class TacksForm extends StatelessWidget {
  const TacksForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TabController? tabController = AppRouter.of(context)
        .navigationTabState
        .tabControllerForTab(HomeScreenTab.tacks);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const PageHeaderWidget(
          descriptionKey: 'tacksScreen.description',
        ),
        const SizedBox(height: 17),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45.0),
          child: AppSegmentController(
            controller: tabController,
            tabs: <int, String>{
              0: FlutterI18n.translate(
                context,
                'tacksScreen.tabs.first',
              ),
              1: FlutterI18n.translate(
                context,
                'tacksScreen.tabs.second',
              ),
            },
          ),
        ),
        const SizedBox(height: 5),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: const <Widget>[
              TackerTacksWidget(),
              RunnerTacksWidget(),
            ],
          ),
        ),
      ],
    );
  }
}
