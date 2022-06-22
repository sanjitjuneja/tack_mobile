import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/models/tack_list_model.dart';
import 'package:flutter/material.dart';

import 'bloc/dashboard_bloc.dart';
import 'bloc/dashboard_state.dart';
import 'bloc/dashboard_event.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashboardBloc>(
      create: (BuildContext context) => DashboardBloc(),
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (BuildContext context, DashboardState state) {
          if (state is DashboardLoading) {
            return const SizedBox.shrink();
          } else if (state is DashboardContent) {
            final List<TackListModel> tacks = state.tacksList;
            return DashboardWidget(
              tacks: tacks,
              user: state.user,
              onTabChanged: () {
                BlocProvider.of<DashboardBloc>(context).add(
                  ChangeRoom(),
                );
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
