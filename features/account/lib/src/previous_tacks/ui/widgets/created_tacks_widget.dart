import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

class CreatedTacksWidget extends StatelessWidget {
  const CreatedTacksWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EmptyWidget(
      svgIcon: AppIconsTheme.tacksList,
      descriptionKey: 'tacksScreen.empty.tackerTacks.description',
      buttonLabelKey: 'tacksScreen.empty.tackerTacks.buttonLabel',
      onButtonTap: () => _onEmptyStateButtonTap(context),
    );
  }

  _onEmptyStateButtonTap(BuildContext context) {}
}
