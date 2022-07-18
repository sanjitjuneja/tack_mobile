import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InvitationsScreen extends StatelessWidget {
  const InvitationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CupertinoPageScaffold(
        backgroundColor: AppTheme.primaryBackgroundColor,
        navigationBar: AppNavigationBar(
          backgroundColor: AppTheme.primaryBackgroundColor,
          withResult: true,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'My Invitations',
                  style: AppTextTheme.manrope24SemiBold.copyWith(
                    color: AppTheme.accentColor,
                  ),
                ),
                const SizedBox(height: 3),
                Padding(
                  padding: EdgeInsets.only(right: 60),
                  child: Text(
                    'Here is a list of all Tack groups you have been invited to.',
                    style: AppTextTheme.manrope13Medium.copyWith(
                      color: AppTheme.textDescriptionColor,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Container(
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
                              padding: EdgeInsets.only(right: 20),
                              child: AppButton(
                                labelKey: 'View',
                                type: ButtonType.secondary,
                                borderColor: AppTheme.buttonLightBorder,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 40),
                          child: AppButton(labelKey: 'Join'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
