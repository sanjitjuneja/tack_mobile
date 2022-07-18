import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:tacks/src/bloc/tacks_bloc.dart';
import 'package:tacks/src/tacks_screen/ui/widgets/tacker_tack/tacker_tack_widget.dart';

class TackerTacksWidget extends StatelessWidget {
  final List<TackerTack> tackerTacks;

  const TackerTacksWidget({
    super.key,
    required this.tackerTacks,
  });

  @override
  Widget build(BuildContext context) {
    if (tackerTacks.isEmpty) {
      return EmptyWidget(
        svgIcon: AppIconsTheme.tacksList,
        descriptionKey: 'tacksScreen.empty.tackerTacks.description',
        buttonLabelKey: 'tacksScreen.empty.tackerTacks.buttonLabel',
        onButtonTap: () => _onEmptyStateButtonTap(context),
      );
    }

    return AppListView(
      itemBuilder: (_, int index) {
        return TackerTackWidget(
          tack: tackerTacks[index],
        );
      },
      itemCount: tackerTacks.length,
    );
  }

  void _onEmptyStateButtonTap(BuildContext context) {
    BlocProvider.of<TacksBloc>(context).add(const MoveToAddTab());
  }
}
