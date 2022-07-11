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
        return AppListView(
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
