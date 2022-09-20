import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';

import '../../models/phone_verification_data.dart';
import '../../models/phone_verification_screen_result.dart';
import '../../models/phone_verification_type.dart';
import '../models/phone_data.dart';
import '../../sms_verification/ui/sms_verification_page.dart';

part 'phone_verification_event.dart';

part 'phone_verification_state.dart';

class PhoneVerificationBloc
    extends Bloc<PhoneVerificationEvent, PhoneVerificationState> {
  final GlobalAppRouterDelegate _appRouter;
  final GetRecoverySmsCodeUseCase _getRecoverySmsCodeUseCase;
  final GetSignUpSmsCodeUseCase _getSignUpSmsCodeUseCase;

  PhoneVerificationBloc({
    required GlobalAppRouterDelegate appRouter,
    required GetRecoverySmsCodeUseCase getRecoverySmsCodeUseCase,
    required GetSignUpSmsCodeUseCase getSignUpSmsCodeUseCase,
    required PhoneVerificationType phoneVerificationType,
  })  : _appRouter = appRouter,
        _getRecoverySmsCodeUseCase = getRecoverySmsCodeUseCase,
        _getSignUpSmsCodeUseCase = getSignUpSmsCodeUseCase,
        super(
          PhoneVerificationState(
            phoneVerificationType: phoneVerificationType,
            phoneData: const PhoneData(
              validator: FieldValidator.validatePhoneNumber,
              fieldAdjuster: FieldValidator.adjustToAmericanNumberIfNeeded,
            ),
          ),
        ) {
    on<PhoneNumberChanged>(_onPhoneNumberChanged);

    on<VerifyAction>(_onVerifyAction);
  }

  Future<void> _onPhoneNumberChanged(
    PhoneNumberChanged event,
    Emitter<PhoneVerificationState> emit,
  ) async {
    emit(
      state.copyWith(phone: event.phoneNumber),
    );
  }

  Future<void> _onVerifyAction(
    VerifyAction event,
    Emitter<PhoneVerificationState> emit,
  ) async {
    try {
      _appRouter.pushProgress();
      final SmsCodeResult result;

      final String phoneNumber = state.phoneData.formattedData;

      switch (state.phoneVerificationType) {
        case PhoneVerificationType.signUp:
          result = await _getSignUpSmsCodeUseCase.execute(
            RequestSmsCodePayload(phoneNumber: phoneNumber),
          );
          break;
        case PhoneVerificationType.forgotPassword:
          result = await _getRecoverySmsCodeUseCase.execute(
            RequestSmsCodePayload(phoneNumber: phoneNumber),
          );
          break;
      }
      final PhoneVerificationData phoneVerificationData = PhoneVerificationData(
        verificationType: state.phoneVerificationType,
        udid: result.uuid,
        phoneNumber: state.phoneData.formattedData,
      );

      emit(
        state.copyWith(phone: ''),
      );

      _appRouter.popProgress();
      final PhoneVerificationData? verificationResult =
          await _appRouter.pushForResult(
        SmsVerificationFeature.page(
          phoneVerificationData: phoneVerificationData,
        ),
      );

      if (verificationResult != null) {
        _appRouter.popWithResult(
          PhoneVerificationScreenResult(
            phoneVerificationData: verificationResult,
          ),
        );
      }
    } on PhoneNumberNotFoundException catch (e) {
      _appRouter.popProgress();
      final bool result = await _appRouter.pushForResult(
        AppAlertDialog.page(
          ErrorAlert(
            contentKey: e.errorDialogContentKey,
          ),
          fullScreen: true,
        ),
      );
      if (result) {
        _appRouter.popWithResult(
          const PhoneVerificationScreenResult(shouldOpenSignUp: true),
        );
      }
    } on PhoneNumberAlreadyExistException catch (e) {
      _appRouter.popProgress();
      final bool result = await _appRouter.pushForResult(
        AppAlertDialog.page(
          ErrorAlert(
            contentKey: e.errorDialogContentKey,
          ),
          fullScreen: true,
        ),
      );
      if (result) {
        _appRouter.popWithResult(
          const PhoneVerificationScreenResult(shouldOpenSignIn: true),
        );
      }
    } on SmsRequestAttemptsExceededException catch (e) {
      _appRouter.popProgress();
      _appRouter.pushForResult(
        AppAlertDialog.page(
          ErrorAlert(
            contentKey: e.errorDialogContentKey,
          ),
          fullScreen: true,
        ),
      );
    } catch (e) {
      _appRouter.popProgress();
      _appRouter.pushForResult(
        AppAlertDialog.page(
          ErrorAlert(
            messageKey: e.toString(),
          ),
        ),
      );
    }
  }
}
