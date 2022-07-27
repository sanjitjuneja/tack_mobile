import 'package:flutter/material.dart';

import '../../core_ui.dart';

class InvitationListWidget extends StatelessWidget {
  final Function onJoin;
  final Function onOpenDetails;

  const InvitationListWidget({
    required this.onJoin,
    required this.onOpenDetails,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 17, 13, 13),
      decoration: BoxDecoration(
        color: AppTheme.positiveColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppTheme.shadowColor,
            offset: const Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 48,
            width: 48,
            decoration: const BoxDecoration(
              color: AppColors.midGrey,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Callaway Group',
                  style: AppTextTheme.manrope16Bold.copyWith(
                    color: AppTheme.accentColor,
                  ),
                ),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: AppButton(
                    labelKey: 'View',
                    type: ButtonType.secondary,
                    borderColor: AppTheme.buttonLightBorder,
                    onTap: onOpenDetails(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 40),
              child: AppButton(
                labelKey: 'Join',
                onTap: onJoin(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
