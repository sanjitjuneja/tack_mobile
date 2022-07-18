import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:tacks/src/bloc/tacks_bloc.dart';
import 'package:tacks/src/tacks_screen/ui/widgets/runner_tack/runner_task_widget.dart';

class RunnerTacksWidget extends StatelessWidget {
  final List<RunnerTack> runnerTacks;

  const RunnerTacksWidget({
    super.key,
    required this.runnerTacks,
  });

  @override
  Widget build(BuildContext context) {
    if (runnerTacks.isEmpty) {
      return EmptyWidget(
        svgIcon: AppIconsTheme.tacksList,
        descriptionKey: 'tacksScreen.empty.runnerTacks.description',
        buttonLabelKey: 'tacksScreen.empty.runnerTacks.buttonLabel',
        onButtonTap: () => _onEmptyStateButtonTap(context),
      );
    }

    return TimeTickerInheritedWidget(
      child: AppListView(
        itemBuilder: (_, int index) {
          return RunnerTackWidget(
            tack: runnerTacks[index],
          );
        },
        itemCount: runnerTacks.length,
      ),
    );
  }

  void _onEmptyStateButtonTap(BuildContext context) {
    BlocProvider.of<TacksBloc>(context).add(const MoveToHomeTab());
  }
}
