import 'package:core/core.dart';
import 'package:core/utils/regular_expressions.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../bloc/personal_information_bloc.dart';
import '../bloc/personal_information_event.dart';
import '../bloc/personal_information_state.dart';

class PersonalInformationScreen extends StatefulWidget {
  final String phoneNumber;

  const PersonalInformationScreen({
    required this.phoneNumber,
    Key? key,
  }) : super(key: key);

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  final TextEditingController codeController = TextEditingController();

  bool radioValue = false;
  String email = '';
  String firstName = '';
  String lastName = '';
  String password = '';
  String confirmedPassword = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalInformationBloc, PersonalInformationState>(
      builder: (BuildContext context, state) {
        return CupertinoPageScaffold(
          navigationBar: AppNavigationBar(
            backgroundColor: AppTheme.secondaryBackgroundColor,
            withResult: true,
          ),
          backgroundColor: AppTheme.positiveColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SafeArea(
              child: KeyboardDismissible(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: CupertinoScrollbar(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                FlutterI18n.translate(
                                  context,
                                  'personalInformation.title',
                                ),
                                style: AppTextTheme.manrope32Bold.copyWith(
                                  color: AppTheme.accentColor,
                                ),
                              ),
                              const SizedBox(height: 16),
                              AppTextFormField(
                                hintText: FlutterI18n.translate(
                                  context,
                                  'personalInformation.firstName',
                                ),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                    lettersOnlyRedEx,
                                  ),
                                ],
                                onChanged: (String value) {
                                  setState(() {
                                    firstName = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 12),
                              AppTextFormField(
                                hintText: FlutterI18n.translate(
                                  context,
                                  'personalInformation.lastName',
                                ),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                    lettersOnlyRedEx,
                                  ),
                                ],
                                onChanged: (String value) {
                                  setState(() {
                                    lastName = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 12),
                              AppTextFormField(
                                keyboardType: TextInputType.emailAddress,
                                hintText: FlutterI18n.translate(
                                  context,
                                  'personalInformation.email',
                                ),
                                onChanged: (String value) {
                                  setState(() {
                                    email = value;
                                  });
                                  BlocProvider.of<PersonalInformationBloc>(
                                          context)
                                      .add(
                                    ValidateEmail(email: value),
                                  );
                                },
                                errorText: state.postValidationErrors?['email'],
                              ),
                              const SizedBox(height: 12),
                              InformationField(
                                information: widget.phoneNumber,
                                description: FlutterI18n.translate(
                                  context,
                                  'personalInformation.phoneNumber',
                                ),
                              ),
                              const SizedBox(height: 12),
                              AppTextFormField(
                                obscureText: true,
                                showObscureButton: true,
                                hintText: FlutterI18n.translate(
                                  context,
                                  'personalInformation.password',
                                ),
                                onChanged: (String value) {
                                  setState(() {
                                    password = value;
                                  });
                                  BlocProvider.of<PersonalInformationBloc>(
                                          context)
                                      .add(
                                    ValidatePassword(
                                      password: password,
                                      confirmedPassword: confirmedPassword,
                                    ),
                                  );
                                },
                              ),
                              ListErrorWidget(
                                isPasswordMatch: false,
                                errors: state.passwordError,
                              ),
                              const SizedBox(height: 12),
                              AppTextFormField(
                                obscureText: true,
                                showObscureButton: true,
                                hintText: FlutterI18n.translate(
                                  context,
                                  'personalInformation.passwordConfirm',
                                ),
                                onChanged: (String value) {
                                  setState(() {
                                    confirmedPassword = value;
                                  });
                                  BlocProvider.of<PersonalInformationBloc>(
                                          context)
                                      .add(
                                    ValidateConfirmedPassword(
                                      password: password,
                                      confirmedPassword: confirmedPassword,
                                    ),
                                  );
                                },
                              ),
                              ListErrorWidget(
                                isPasswordMatch: true,
                                errors: state.confirmedPasswordError,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: 12,
                                ),
                                child: TermsConditionsResolver(
                                  onChanged: (bool value) {
                                    setState(() {
                                      radioValue = value;
                                    });
                                    BlocProvider.of<PersonalInformationBloc>(
                                            context)
                                        .add(
                                      ValidateTermsConditions(
                                        isConditionsAccepted: value,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    KeyboardVisibilityWidget(
                      child: RoundedCustomButton(
                        height: 60,
                        isEnabled: isButtonEnabled(
                          isValidationsPassed: state.isValidationsPassed,
                        ),
                        backgroundColor: AppTheme.grassColor,
                        text: 'personalInformation.buttonTitle',
                        disabledBackgroundColor: AppTheme.buttonDisabledColor,
                        textStyle: AppTextTheme.manrope20Medium.copyWith(
                          color: AppTheme.positiveColor,
                        ),
                        disabledTextStyle:
                            AppTextTheme.manrope20Medium.copyWith(
                          color: AppTheme.accentColor,
                        ),
                        borderRadius: BorderRadius.circular(35),
                        onPressed: () {
                          BlocProvider.of<PersonalInformationBloc>(context).add(
                            RegisterUser(
                              email: email,
                              password: password,
                              firstName: firstName,
                              lastName: lastName,
                              phoneNumber: widget.phoneNumber,
                              confirmedPassword: confirmedPassword,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  bool isButtonEnabled({
    required bool isValidationsPassed,
  }) {
    return isValidationsPassed &&
        email.isNotEmpty &&
        firstName.isNotEmpty &&
        lastName.isNotEmpty;
  }
}
