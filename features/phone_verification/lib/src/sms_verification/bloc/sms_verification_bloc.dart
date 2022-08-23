import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';

import '../../models/phone_verification_data.dart';
import '../../models/phone_verification_type.dart';
import '../models/sms_code_data.dart';

part 'sms_verification_event.dart';

part 'sms_verification_state.dart';

class SmsVerificationBloc
    extends Bloc<SmsVerificationEvent, SmsVerificationState> {
  static const int _verificationCodeLength = 6;

  final GlobalAppRouterDelegate _appRouter;
  final GetRecoverySmsCodeUseCase _getRecoverySmsCodeUseCase;
  final GetSignUpSmsCodeUseCase _getSignUpSmsCodeUseCase;
  final VerifyPhoneNumberUseCase _verifyPhoneNumberUseCase;

  SmsVerificationBloc({
    required PhoneVerificationData phoneVerificationData,
    required GlobalAppRouterDelegate appRouter,
    required GetRecoverySmsCodeUseCase getRecoverySmsCodeUseCase,
    required GetSignUpSmsCodeUseCase getSignUpSmsCodeUseCase,
    required VerifyPhoneNumberUseCase verifyPhoneNumberUseCase,
  })  : _appRouter = appRouter,
        _getRecoverySmsCodeUseCase = getRecoverySmsCodeUseCase,
        _getSignUpSmsCodeUseCase = getSignUpSmsCodeUseCase,
        _verifyPhoneNumberUseCase = verifyPhoneNumberUseCase,
        super(
          SmsVerificationState(
            phoneVerificationData: phoneVerificationData,
            codeData: const SmsCodeData(
              validator: __isCodeValid,
            ),
          ),
        ) {
    on<CodeChanged>(_onCodeChanged);

    on<ResendCodeAction>(_onResendCodeAction);
    on<VerifyNumberAction>(_onVerifyNumberAction);
  }

  Future<void> _onCodeChanged(
    CodeChanged event,
    Emitter<SmsVerificationState> emit,
  ) async {
    emit(
      state.copyWith(code: event.verificationCode),
    );
  }

  Future<void> _onResendCodeAction(
    ResendCodeAction event,
    Emitter<SmsVerificationState> emit,
  ) async {
    try {
      _appRouter.push(ProgressDialog.page());
      final SmsCodeResult result;

      final String phoneNumber = state.phoneVerificationData.phoneNumber;

      switch (state.phoneVerificationData.verificationType) {
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

      _appRouter.pop();
      emit(
        state.copyWith(
          phoneVerificationData: PhoneVerificationData(
            verificationType: state.phoneVerificationData.verificationType,
            udid: result.uuid,
            phoneNumber: state.phoneVerificationData.phoneNumber,
          ),
        ),
      );
    } catch (e) {
      _appRouter.pop();
      _appRouter.pushForResult(
        AppAlertDialog.page(
          ErrorAlert(
            messageKey: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _onVerifyNumberAction(
    VerifyNumberAction event,
    Emitter<SmsVerificationState> emit,
  ) async {
    try {
      _appRouter.push(
        ProgressDialog.page(messageKey: 'smsVerificationScreen.loadingTitle'),
      );

      await _verifyPhoneNumberUseCase.execute(
        VerifyPhoneNumberPayload(
          uuid: state.phoneVerificationData.udid,
          smsCode: state.codeData.code,
        ),
      );

      _appRouter.pop();
      _appRouter.popWithResult(state.phoneVerificationData);
    } catch (e) {
      _appRouter.pop();
      _appRouter.pushForResult(
        AppAlertDialog.page(
          ErrorAlert(
            messageKey: e.toString(),
          ),
        ),
      );
    }
  }

  static bool __isCodeValid(String verificationCode) {
    return verificationCode.length == _verificationCodeLength;
  }
}
