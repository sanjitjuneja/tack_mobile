import 'package:core/localization/app_localization.dart';
import 'package:core/utils/currency_utils.dart';
import 'package:domain/models/tack_list_model.dart';
import 'package:flutter/material.dart';

import '../../core_ui.dart';

class TackListWidget extends StatelessWidget {
  final TackListModel tack;

  const TackListWidget({
    required this.tack,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: AppTheme.shadowColor,
            offset: Offset(0, 7),
            spreadRadius: -5,
            blurRadius: 6,
          ),
        ],
        color: AppTheme.positiveColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              top: 12,
              right: 12,
              bottom: 15,
            ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        tack.title,
                        style: AppTextTheme.manrope16SemiBold.copyWith(
                          color: AppTheme.accentColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 50),
                    Text(
                      dollarFormat.format(tack.price),
                      style: AppTextTheme.manrope24Bold.copyWith(
                        color: AppTheme.grassColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                TackTimeWidget(
                  time: tack.primaryDelay,
                  tackerName: tack.tackerName,
                  timeAgo: tack.secondaryDelay,
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 16,
            ),
            child: Row(
              children: <Widget>[
                AppImagesTheme.temporaryAvatar,
                const SizedBox(width: 8),
                TackStatisticWidget(
                  image: AppImagesTheme.star,
                  value: tack.rating.toString(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    width: 1,
                    height: 10,
                    color: AppTheme.hintColor,
                  ),
                ),
                TackStatisticWidget(
                  image: AppImagesTheme.message,
                  value: tack.reviewsCount.toString(),
                  description: AppLocalizations.of(context).value(
                    'dashboard.list.reviews',
                  ),
                ),
                const Spacer(),
                AppButton(
                  text: AppLocalizations.of(context).value('button.accept'),
                  height: 38,
                  width: 90,
                  backgroundColor: AppTheme.grassColor,
                  borderSide: const BorderSide(
                    width: 1,
                    color: AppTheme.positiveColor,
                  ),
                  shadows: const [
                    BoxShadow(
                      color: AppTheme.shadowColor,
                      offset: Offset(0, 10),
                      spreadRadius: -8,
                      blurRadius: 12,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
