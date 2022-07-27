import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InvitationDetailsScreen extends StatelessWidget {
  const InvitationDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.primaryBackgroundColor,
      navigationBar: AppNavigationBar(
        backgroundColor: AppTheme.primaryBackgroundColor,
        withResult: false,
        actions: const <Widget>[
          SizedBox(
            width: 160,
            child: AppButton(
              labelKey: 'Mute Notifications',
              type: ButtonType.secondary,
            ),
          )
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              const SizedBox(height: 26),
              Text(
                'Members',
                style: AppTextTheme.manrope20Light.copyWith(
                  color: AppTheme.accentColor,
                ),
              ),
              const SizedBox(height: 16),
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
                    const Spacer(),
                    AppImagesTheme.star,
                    const Text(' 5.00'),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Container(
                        height: 14,
                        width: 2,
                        color: AppTheme.buttonDisabledColor,
                      ),
                    ),
                    AppIconsTheme.tack.call(),
                    const Text('125 Tacks'),
                  ],
                ),
              ),
              const Spacer(),
              RoundedCustomButton(
                height: 60,
                text: FlutterI18n.translate(
                  context,
                  'Invite Members',
                ),
                backgroundColor: AppTheme.grassColor,
                borderRadius: BorderRadius.circular(35),
                textStyle: AppTextTheme.manrope16SemiBold.copyWith(
                  color: AppTheme.positiveColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
