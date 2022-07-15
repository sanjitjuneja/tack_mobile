import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

class InviteMembersDivider extends StatelessWidget {
  const InviteMembersDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Expanded(
          child: AppDivider(),
        ),
        const SizedBox(width: 5),
        Text(
          FlutterI18n.translate(
            context,
            'general.or',
          ).toUpperCase(),
          style: AppTextTheme.manrope14SemiBold
              .copyWith(color: AppTheme.textHeavyHintColor),
        ),
        const SizedBox(width: 5),
        const Expanded(
          child: AppDivider(),
        ),
      ],
    );
  }
}
