import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InvitationDetailsScreen extends StatelessWidget {
  const InvitationDetailsScreen({super.key});

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
              children: <Widget>[
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
                  child: Column(
                    children: <Widget>[
                      Row(
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
                          Text(
                            'Callaway Group',
                            style: AppTextTheme.manrope24SemiBold.copyWith(
                              color: AppTheme.accentColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      AppDivider(),
                      const SizedBox(height: 14),
                      Text(
                        'Callaway 2022-2023 Tack Group (Pay other residents to do anything)',
                        style: AppTextTheme.manrope14Light.copyWith(
                          color: AppTheme.accentColor,
                        ),
                      ),
                    ],
                  ),
                ),

                ////////////////
                const SizedBox(height: 24),
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
                    children: <Widget>[
                      Text(
                        'Reed Wilson',
                        style: AppTextTheme.manrope16Bold
                            .copyWith(color: AppTheme.accentColor),
                      ),
                      Spacer(),
                      AppImagesTheme.star,
                      Text(' 5.00'),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Container(
                          height: 14,
                          width: 2,
                          color: AppTheme.buttonDisabledColor,
                        ),
                      ),
                      AppIconsTheme.tack.call(),
                      Text('125 Tacks'),
                    ],
                  ),
                ),
                Spacer(),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: AppCircleButton(
                        labelKey: 'Ignore',
                        type: AppButtonType.secondary,
                      ),
                    ),
                    Expanded(
                      child: AppCircleButton(
                        labelKey: 'Join',
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
