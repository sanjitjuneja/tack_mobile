import 'package:core_ui/core_ui.dart';
import 'package:flutter/widgets.dart';

class PageIndicator extends StatelessWidget {
  final PageController pageController;
  final int pageCount;

  const PageIndicator({
    super.key,
    required this.pageController,
    required this.pageCount,
  });

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: pageController,
      count: pageCount,
      effect: WormEffect(
        dotWidth: 10,
        dotHeight: 10,
        dotColor: AppTheme.pageIndicatorInactiveColor,
        activeDotColor: AppTheme.pageIndicatorActiveColor,
      ),
    );
  }
}
