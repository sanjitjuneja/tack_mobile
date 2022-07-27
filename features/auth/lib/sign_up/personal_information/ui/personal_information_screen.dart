import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

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
  String firstName = '';
  String lastName = '';
  String password = '';
  String confirmedPassword = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalInformationBloc, PersonalInformationState>(
      builder: (BuildContext context, state) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            border: null,
            backgroundColor: AppTheme.primaryColor,
            leading: CupertinoButton(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              onPressed: () => AppRouter.of(context).popWithResult(true),
              child: Row(
                children: [
                  AppImagesTheme.backArrow,
                  const SizedBox(width: 16),
                  Text(
                    FlutterI18n.translate(context, 'general.back'),
                    style: AppTextTheme.manrope16Light.copyWith(
                      color: AppTheme.textPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
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
                              const SizedBox(height: 70),
                              AppTextFormField(
                                hintText: FlutterI18n.translate(
                                  context,
                                  'personalInformation.firstName',
                                ),
                                onChanged: (String value) {
                                  setState(() {
                                    firstName = value;
                                  });
                                  BlocProvider.of<PersonalInformationBloc>(
                                          context)
                                      .add(
                                    ValidateFirstName(firstName: value),
                                  );
                                },
                              ),
                              if (state.firstNameError != null) ...<Widget>{
                                ListErrorWidget(
                                  errors: state.firstNameError!,
                                ),
                              },
                              const SizedBox(height: 12),
                              AppTextFormField(
                                hintText: FlutterI18n.translate(
                                  context,
                                  'personalInformation.lastName',
                                ),
                                onChanged: (String value) {
                                  setState(() {
                                    lastName = value;
                                  });
                                  BlocProvider.of<PersonalInformationBloc>(
                                          context)
                                      .add(
                                    ValidateLastName(lastName: value),
                                  );
                                },
                              ),
                              if (state.secondNameError != null) ...<Widget>{
                                ListErrorWidget(
                                  errors: state.secondNameError!,
                                ),
                              },
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
                                    ValidatePassword(password: value),
                                  );
                                },
                                errorText:
                                    state.postValidationErrors?['password'],
                              ),
                              if (state.passwordError != null) ...<Widget>{
                                ListErrorWidget(
                                  errors: state.passwordError!,
                                ),
                              },
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
                                    ValidateConfirmedPassword(password: value),
                                  );
                                },
                                errorText: state
                                    .postValidationErrors?['confirmedPassword'],
                              ),
                              if (state.confirmedPasswordError !=
                                  null) ...<Widget>{
                                ListErrorWidget(
                                  errors: state.confirmedPasswordError!,
                                ),
                              },
                            ],
                          ),
                        ),
                      ),
                    ),
                    KeyboardVisibilityWidget(
                      child: Column(
                        children: <Widget>[
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
                          RoundedCustomButton(
                            height: 60,
                            isEnabled: state.isValidationsPassed,
                            backgroundColor: AppTheme.grassColor,
                            text: 'personalInformation.buttonTitle',
                            disabledBackgroundColor:
                                AppTheme.buttonDisabledColor,
                            textStyle: AppTextTheme.manrope20Medium.copyWith(
                              color: AppTheme.positiveColor,
                            ),
                            disabledTextStyle:
                                AppTextTheme.manrope20Medium.copyWith(
                              color: AppTheme.accentColor,
                            ),
                            borderRadius: BorderRadius.circular(35),
                            onPressed: () {
                              BlocProvider.of<PersonalInformationBloc>(context)
                                  .add(
                                RegisterUser(
                                  password: password,
                                  firstName: firstName,
                                  lastName: lastName,
                                  phoneNumber: widget.phoneNumber,
                                  confirmedPassword: confirmedPassword,
                                ),
                              );
                            },
                          ),
                        ],
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
}
