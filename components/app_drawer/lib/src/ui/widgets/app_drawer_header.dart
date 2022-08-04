import 'package:app_drawer/src/bloc/app_drawer_bloc.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class AppDrawerHeader extends StatelessWidget {
  const AppDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppDrawerBloc, AppDrawerState>(
      builder: (_, AppDrawerState state) {
        return Container(
          color: AppTheme.accentColor,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 16.0,
              ),
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
                            color: AppTheme.positiveColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        CurrencyUtility.dollarFormat
                            .format(state.user.bankAccount.usdBalance),
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
          ),
        );
      },
    );
  }
}
