import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

class TackTileActions extends StatelessWidget {
  const TackTileActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: AppButton(
            label: FlutterI18n.translate(context, 'general.counter'),
            type: ButtonType.secondary,
            withShadow: false,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: AppButton(
            label: FlutterI18n.translate(context, 'general.accept'),
            icon: AppIconsTheme.edit,
          ),
        ),
      ],
    );
  }
}
