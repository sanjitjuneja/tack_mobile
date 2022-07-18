import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:tacks/src/bloc/tacks_bloc.dart';
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
                  BlocProvider.of<TacksBloc>(context).add(const LoadTacks());
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 18, right: 42),
                  child: Text(
                    FlutterI18n.translate(context, 'tacksScreen.description'),
                    style: AppTextTheme.manrope13Medium.copyWith(
                      color: AppTheme.textHintColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 17),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45.0),
                child: AppSegmentController(
                  tabs: <String>[
                    FlutterI18n.translate(context, 'tacksScreen.tackerTab'),
                    FlutterI18n.translate(context, 'tacksScreen.runnerTab'),
                  ],
                ),
              ),
              const SizedBox(height: 17),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    TackerTacksWidget(tackerTacks: state.tackerTacks),
                    RunnerTacksWidget(runnerTacks: state.runnerTacks),
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