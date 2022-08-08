import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import 'package:tacks/src/tacks_screen/bloc/tacks_bloc.dart';
import 'package:tacks/src/tacks_screen/ui/widgets/runner_tacks_widget.dart';
import 'package:tacks/src/tacks_screen/ui/widgets/tacker_tacks_widget.dart';

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
    return BlocBuilder<TacksBloc, TacksState>(
      builder: (_, TacksState state) {
        return DefaultTabController(
          length: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  BlocProvider.of<TacksBloc>(context)
                      .add(const LoadMockedData());
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 18, right: 42),
                  child: Text(
                    FlutterI18n.translate(context, 'tacksScreen.description'),
                    style: AppTextTheme.manrope13Medium.copyWith(
                      color: AppTheme.textHeavyHintColor,
                    ),
                  ),
                ),
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
              const SizedBox(height: 17),
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
      },
    );
  }
}
