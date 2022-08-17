import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../bloc/splash_bloc.dart';

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

    BlocProvider.of<SplashBloc>(context).add(InitialEvent(_panelController));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashBloc, SplashState>(
      builder: (BuildContext context, SplashState state) {
        return Scaffold(
          backgroundColor: AppTheme.registrationBackGroundColor,
          body: Stack(
            children: [
              SafeArea(
                child: Column(
                  children: <Widget>[
                    const Spacer(flex: 2),
                    Center(
                      child: AppImagesTheme.appLogo,
                    ),
                    const Spacer(flex: 3),
                  ],
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
                        AppCircleButton(
                          labelKey: 'signIn.buttonSignIn',
                          interfaceSize: AppInterfaceSize.big,
                          onTap: _onSignInPressed,
                          backgroundColor: AppTheme.grassColor,
                        ),
                        const SizedBox(height: 24),
                        AppCircleButton(
                          labelKey: 'signUp.buttonSignUp',
                          interfaceSize: AppInterfaceSize.big,
                          backgroundColor: AppTheme.buttonDisabledColor,
                          borderColor: AppTheme.buttonDisabledColor,
                          interfaceColor: AppTheme.textPrimaryColor,
                          onTap: _onSignUpPressed,
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

  void _onSignInPressed() {
    BlocProvider.of<SplashBloc>(context).add(
      SignIn(_panelController),
    );
  }

  void _onSignUpPressed() {
    BlocProvider.of<SplashBloc>(context).add(
      SignUp(_panelController),
    );
  }
}
