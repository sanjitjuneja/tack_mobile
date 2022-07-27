import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import 'package:tacks/src/rate_tack_user/bloc/rate_tack_user_bloc.dart';

class RatingSection extends StatelessWidget {
  final RateTackUserState state;

  const RatingSection({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.3,
      ),
      decoration: BoxDecoration(
        color: AppTheme.ratingBackgroundColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            state.tackUser.fullName,
            textAlign: TextAlign.center,
            style: AppTextTheme.manrope24SemiBold
                .copyWith(color: AppTheme.textBrightColor),
          ),
          const SizedBox(height: 20),
          Text(
            state.tack.title,
            textAlign: TextAlign.center,
            style: AppTextTheme.manrope16SemiBold
                .copyWith(color: AppTheme.textBrightColor),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Center(
              child: RateWidget(
                minRating: state.rateData.minRate,
                maxRating: state.rateData.maxRate,
                onRatingUpdate: _onRatingChange,
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  void _onRatingChange(BuildContext context, double rating) {
    BlocProvider.of<RateTackUserBloc>(context).add(RatingChange(rating));
  }
}
