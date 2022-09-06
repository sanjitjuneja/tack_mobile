import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:home/home.dart';
import 'package:navigation/navigation.dart';
import 'package:phone_verification/phone_verification.dart';

part 'onboarding_event.dart';

part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final GlobalAppRouterDelegate _globalAppRouter;

  OnboardingBloc({
    required GlobalAppRouterDelegate globalAppRouter,
  })  : _globalAppRouter = globalAppRouter,
        super(const OnboardingState()) {
    on<SignUpAction>(_onSignUpAction);
    on<SignInAction>(_onSignInAction);
  }

  Future<void> _onSignUpAction(
    SignUpAction event,
    Emitter<OnboardingState> emit,
  ) async {
    final PhoneVerificationScreenResult? phoneVerificationScreenResult =
        await _globalAppRouter.pushForResult(
      PhoneVerificationFeature.pageForSignUp(),
    );

    if (phoneVerificationScreenResult == null) return;

    if (phoneVerificationScreenResult.shouldOpenSignIn) {
      add(const SignInAction());
    } else {
      final bool? result = await _globalAppRouter.pushForResult(
        SignUpFeature.page(
          phoneVerificationData:
              phoneVerificationScreenResult.phoneVerificationData!,
        ),
      );

      if (result == true) {
        _globalAppRouter.replace(FirstRouteFeature.page());
      }
    }
  }

  Future<void> _onSignInAction(
    SignInAction event,
    Emitter<OnboardingState> emit,
  ) async {
    final bool? result = await _globalAppRouter.pushForResult(
      SignInFeature.page(),
    );

    if (result == true) {
      _globalAppRouter.replace(FirstRouteFeature.page());
    }
  }
}
