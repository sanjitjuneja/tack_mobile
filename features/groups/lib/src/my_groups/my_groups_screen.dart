import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyGroupsScreen extends StatelessWidget {
  const MyGroupsScreen({super.key});

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
                  'My Groups',
                  style: AppTextTheme.manrope24SemiBold.copyWith(
                    color: AppTheme.accentColor,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Select one of the following groups to switch your current app view',
                  style: AppTextTheme.manrope13Medium.copyWith(
                    color: AppTheme.descriptionTextColor,
                  ),
                ),
                const SizedBox(height: 15),
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
                              'Callaway Group',
                              style: AppTextTheme.manrope16Bold.copyWith(
                                color: AppTheme.accentColor,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Padding(
                              padding: EdgeInsets.only(right: 2),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: AppButton(
                                      labelKey: 'Group Info',
                                      type: ButtonType.secondary,
                                      borderColor: AppTheme.lightButtonBorder,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: AppButton(
                                      labelKey: 'Invite',
                                      type: ButtonType.secondary,
                                      borderColor: AppTheme.lightButtonBorder,
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
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: AppButton(labelKey: 'My Invintations'),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppButton(
                        labelKey: 'Create Group',
                        type: ButtonType.secondary,
                        // borderColor: AppTheme.lightButtonBorder,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
