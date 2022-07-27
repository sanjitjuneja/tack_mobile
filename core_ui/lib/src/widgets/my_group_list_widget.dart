import 'package:flutter/cupertino.dart';

import '../../core_ui.dart';

class MyGroupListWidget extends StatelessWidget {
  final String groupName;
  final Function onOpenDetails;
  final Function onInviteMembers;

  const MyGroupListWidget({
    required this.groupName,
    required this.onOpenDetails,
    required this.onInviteMembers,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onOpenDetails();
      },
      child: Container(
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    groupName,
                    style: AppTextTheme.manrope16Bold.copyWith(
                      color: AppTheme.accentColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.only(right: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: AppButton(
                            labelKey: 'Group Info',
                            type: ButtonType.secondary,
                            borderColor: AppTheme.buttonLightBorder,
                            onTap: () {
                              onOpenDetails();
                            },
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: AppButton(
                            labelKey: 'Invite',
                            type: ButtonType.secondary,
                            borderColor: AppTheme.buttonLightBorder,
                            onTap: () {
                              onInviteMembers();
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
