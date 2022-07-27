import 'package:core_ui/src/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateWidget extends StatelessWidget {
  final int minRating;
  final int maxRating;
  final void Function(BuildContext context, double rating)? onRatingUpdate;

  const RateWidget({
    super.key,
    this.minRating = 1,
    this.maxRating = 5,
    this.onRatingUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return RatingBar(
      ratingWidget: RatingWidget(
        empty: AppIconsTheme.rateStar(color: AppTheme.ratingEmptyColor),
        full: AppIconsTheme.rateStar(color: AppTheme.ratingFilledColor),
        half: const SizedBox.shrink(),
      ),
      initialRating: 0,
      itemCount: maxRating,
      minRating: minRating.toDouble(),
      direction: Axis.horizontal,
      allowHalfRating: false,
      glow: false,
      itemPadding: const EdgeInsets.symmetric(horizontal: 6.0),
      onRatingUpdate: (double rating) {
        onRatingUpdate?.call(context, rating);
      },
    );
  }
}
