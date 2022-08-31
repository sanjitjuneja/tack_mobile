import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import 'widgets/completed_tacks_widget.dart';
import 'widgets/created_tacks_widget.dart';

class PreviousTacksForm extends StatelessWidget {
  const PreviousTacksForm({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10),
          const PageHeaderWidget(
            titleKey: 'previousTacksScreen.title',
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: AppSegmentController(
              tabs: <int, String>{
                0: FlutterI18n.translate(
                  context,
                  'previousTacksScreen.tabs.first',
                ),
                1: FlutterI18n.translate(
                  context,
                  'previousTacksScreen.tabs.second',
                ),
              },
            ),
          ),
          const SizedBox(height: 10),
          const Expanded(
            child: TabBarView(
              children: <Widget>[
                CreatedTacksWidget(),
                CompletedTacksWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
