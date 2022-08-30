import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import 'widgets/runner_tacks_widget.dart';
import 'widgets/tacker_tacks_widget.dart';

class TacksForm extends StatefulWidget {
  const TacksForm({
    super.key,
  });

  @override
  State<TacksForm> createState() => _TacksFormState();
}

class _TacksFormState extends State<TacksForm> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const PageHeaderWidget(
            descriptionKey: 'tacksScreen.description',
          ),
          const SizedBox(height: 17),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45.0),
            child: AppSegmentController(
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
          const Expanded(
            child: TabBarView(
              children: <Widget>[
                TackerTacksWidget(),
                RunnerTacksWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
