import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:dashboard/src/bloc/dashboard_bloc.dart';
import 'package:dashboard/src/widgets/tack_tile.dart';
import 'package:flutter/cupertino.dart';

class DashboardForm extends StatelessWidget {
  const DashboardForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (_, DashboardState state) {
        return AppListViewWithRefresh(
          enableRefresh: true,
          onRefresh: (Completer<RefreshingStatus> completer) {
            Future.delayed(
              const Duration(milliseconds: 1000),
              () {
                completer.complete(RefreshingStatus.complete);
              },
            );
          },
          enableLoad: true,
          onLoad: (Completer<LoadingStatus> completer) {
            Future.delayed(
              const Duration(milliseconds: 1000),
              () {
                completer.complete(LoadingStatus.complete);
              },
            );
          },
          itemCount: state.tacks.length,
          itemBuilder: (_, int index) {
            return TackTile(
              tack: state.tacks[index],
            );
          },
        );
      },
    );
  }
}
