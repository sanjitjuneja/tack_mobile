import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import 'package:create_tack/src/bloc/create_tack_bloc.dart';
import 'package:create_tack/src/ui/widgets/group_popular_tacks_widget.dart';
import 'package:create_tack/src/ui/widgets/nearby_popular_tacks_widget.dart';

class CreateTackForm extends StatelessWidget {
  const CreateTackForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTackBloc, CreateTackState>(
      builder: (_, CreateTackState state) {
        return PageContainerWithAddButton(
          onAddButtonPressed: _onAddButtonPressed,
          child: DefaultTabController(
            length: 2,
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
                const Expanded(
                  child: TabBarView(
                    children: <Widget>[
                      NearbyPopularTacksWidget(),
                      GroupPopularTacksWidget(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onAddButtonPressed(BuildContext context) {
    BlocProvider.of<CreateTackBloc>(context).add(const CreateTackAction());
  }
}
