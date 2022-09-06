import 'package:core_ui/core_ui.dart';
import 'package:flutter/widgets.dart';

import 'widgets/onboarding_actions.dart';
import 'widgets/onboarding_page.dart';
import 'widgets/page_indicator.dart';

class OnboardingForm extends StatefulWidget {
  const OnboardingForm({super.key});

  @override
  State<OnboardingForm> createState() => _OnboardingFormState();
}

class _OnboardingFormState extends State<OnboardingForm> {
  final PageController pageController = PageController();

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _pages = <Widget>[
      OnboardingPage(
        titleKey: 'onboardingScreen.first.title',
        descriptionKey: 'onboardingScreen.first.description',
        image: AppImagesTheme.onboardingFirst,
      ),
      OnboardingPage(
        titleKey: 'onboardingScreen.second.title',
        descriptionKey: 'onboardingScreen.second.description',
        image: AppImagesTheme.onboardingSecond,
      ),
      OnboardingPage(
        titleKey: 'onboardingScreen.third.title',
        descriptionKey: 'onboardingScreen.third.description',
        image: AppImagesTheme.onboardingThird,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 56,
          child: AppImagesTheme.appLogo,
        ),
        Expanded(
          child: PageView(
            scrollDirection: Axis.horizontal,
            controller: pageController,
            children: _pages,
          ),
        ),
        const SizedBox(height: 20),
        PageIndicator(
          pageController: pageController,
          pageCount: _pages.length,
        ),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 56.0),
          child: OnboardingActions(),
        ),
        const SizedBox(height: 6),
      ],
    );
  }
}
