import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:splash/bloc/splash_bloc.dart';

import 'bloc/splash_event.dart';
import 'bloc/splash_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _panelController;

  @override
  void initState() {
    super.initState();
    _panelController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      value: 0,
    );

    _panelController.animateTo(
      0.3,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
      listener: (BuildContext context, SplashState state) {
        if (state is SplashContent) {
          if (state.needToBackAnimation != null && state.needToBackAnimation!) {
            startPopAnimation();
          }
        }
      },
      builder: (BuildContext context, SplashState state) {
        return Scaffold(
          backgroundColor: AppTheme.registrationBackGroundColor,
          body: Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 140),
                  child: AppImagesTheme.appLogo,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SlidePanelWidget(
                  controller: _panelController,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: <Widget>[
                        RoundedCustomButton(
                          text: 'signIn.buttonSignIn',
                          textStyle: AppTextTheme.manrope20Medium.copyWith(
                            color: AppTheme.positiveColor,
                          ),
                          height: 68,
                          borderRadius: BorderRadius.circular(35),
                          onPressed: () async {
                            await _panelController.animateTo(
                              1.0,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                            if(!mounted) return;

                            BlocProvider.of<SplashBloc>(context).add(
                              SignIn(),
                            );
                          },
                          backgroundColor: AppTheme.grassColor,
                        ),
                        const SizedBox(height: 24),
                        RoundedCustomButton(
                          text: 'signUp.buttonSignUp',
                          textStyle: AppTextTheme.manrope20Medium.copyWith(
                            color: AppTheme.accentColor,
                          ),
                          height: 68,
                          borderRadius: BorderRadius.circular(35),
                          backgroundColor: AppTheme.buttonDisabledColor,
                          onPressed: () async {
                            await _panelController.animateTo(
                              1.0,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                            if(!mounted) return;

                            BlocProvider.of<SplashBloc>(context).add(
                              SignUp(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void startPopAnimation() async {
    await _panelController.animateTo(
      0.3,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
}
