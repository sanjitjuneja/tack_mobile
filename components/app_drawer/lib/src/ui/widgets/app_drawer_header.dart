import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../../bloc/app_drawer_bloc.dart';

class AppDrawerHeader extends StatelessWidget {
  const AppDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppDrawerBloc, AppDrawerState>(
      builder: (_, AppDrawerState state) {
        return Container(
          color: AppTheme.accentColor,
          padding: const EdgeInsets.only(
            left: 16.0,
            top: 10.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        state.user.fullName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextTheme.manrope24SemiBold.copyWith(
                          color: AppTheme.textBrightColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      CurrencyUtility.dollarFormat.format(
                        state.userBalance.usdBalance,
                      ),
                      style: AppTextTheme.manrope26Bold
                          .copyWith(color: AppTheme.textSecondaryColor),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                UserStatsWidget.fromUser(user: state.user)
              ],
            ),
          ),
        );
      },
    );
  }
}
