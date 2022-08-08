import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

class CompletedTacksWidget extends StatelessWidget {
  const CompletedTacksWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EmptyWidget(
      svgIcon: AppIconsTheme.tacksList,
      descriptionKey: 'Looks like you don’t haven’t completed any previous Tacks. Go to the Home Feed to find your first Tack to complete.',
      buttonLabelKey: 'Home Feed',
      onButtonTap: () => _onEmptyStateButtonTap(context),
    );
  }

  _onEmptyStateButtonTap(BuildContext context) {}
}
