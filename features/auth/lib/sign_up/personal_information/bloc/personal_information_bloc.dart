import 'dart:async';

import 'package:auth/connect_third_paty/connect_third_party_page.dart';
import 'package:auth/sign_up/personal_information/bloc/personal_information_event.dart';
import 'package:auth/sign_up/personal_information/bloc/personal_information_state.dart';
import 'package:core/core.dart';
import 'package:domain/params_models/sign_up_params.dart';
import 'package:domain/usecases/sign_up_usecase.dart';
import 'package:navigation/navigation.dart';

class PersonalInformationBloc
    extends Bloc<PersonalInformationEvent, PersonalInformationState> {
  final AppRouterDelegate appRouter;
  final SignUpUseCase signUpUseCase;
  final String udid;

  PersonalInformationBloc({
    required this.udid,
    required this.appRouter,
    required this.signUpUseCase,
  }) : super(PersonalInformationContent());

  bool isDataValid = false;
  bool isPasswordDataValid = false;

  @override
  Stream<PersonalInformationState> mapEventToState(
      PersonalInformationEvent event) async* {
    if (event is RegisterUser) {
      try {
        await signUpUseCase.execute(
          SignUpParams(
            user: event.user,
            uuid: udid,
          ),
        );

        appRouter.push(ConnectThirdPartyPage());
      } on Exception catch (e) {}
    }

    if (event is RouteBack) {
      appRouter.pop();
    }
  }

  Map<String, String> _validateData({
    required String firstName,
    required String lastName,
    required bool isTermsAccepted,
  }) {
    return {};
  }
}
