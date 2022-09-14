import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:domain/use_case.dart';
import 'package:home/home.dart';
import 'package:navigation/navigation.dart';
import 'package:phone_verification/phone_verification.dart';

part 'onboarding_event.dart';

part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final GlobalAppRouterDelegate _globalAppRouter;
  final RequestNotificationsPermissionsUseCase
      _requestNotificationsPermissionsUseCase;

  OnboardingBloc({
    required GlobalAppRouterDelegate globalAppRouter,
    required RequestNotificationsPermissionsUseCase
        requestNotificationsPermissionsUseCase,
  })  : _globalAppRouter = globalAppRouter,
        _requestNotificationsPermissionsUseCase =
            requestNotificationsPermissionsUseCase,
        super(const OnboardingState()) {
    on<RequestNotificationsPermissions>(_onRequestNotificationsPermissions);
    on<SignUpAction>(_onSignUpAction);
    on<SignInAction>(_onSignInAction);

    add(const RequestNotificationsPermissions());
  }

  Future<void> _onRequestNotificationsPermissions(
    RequestNotificationsPermissions event,
    Emitter<OnboardingState> emit,
  ) async {
    _requestNotificationsPermissionsUseCase.execute(NoParams());
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
