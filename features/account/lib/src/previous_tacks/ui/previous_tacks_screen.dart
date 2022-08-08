import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import 'package:account/src/previous_tacks/ui/widgets/completed_tacks_widget.dart';
import 'package:account/src/previous_tacks/ui/widgets/created_tacks_widget.dart';

class PreviousTacksScreen extends StatelessWidget {
  const PreviousTacksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Previous Tacks',
            style: AppTextTheme.manrope20Medium.copyWith(
              color: AppTheme.accentColor,
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 45.0),
                    child: AppSegmentController(
                      tabs: <int, String>{
                        1: FlutterI18n.translate(context, 'Created'),
                        2: FlutterI18n.translate(context, 'Completed'),
                      },
                    ),
                  ),
                  const SizedBox(height: 17),
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
            ),
          ),
        ],
      ),
    );
  }
}
