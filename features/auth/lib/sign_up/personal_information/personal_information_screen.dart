import 'package:auth/connect_third_paty/connect_third_party_page.dart';
import 'package:core/core.dart';
import 'package:core/di/app_di.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import 'bloc/personal_information_bloc.dart';
import 'bloc/personal_information_event.dart';
import 'bloc/personal_information_state.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  final TextEditingController codeController = TextEditingController();

  bool isButtonAvailable = false;
  bool radioValue = false;
  String fullName = '';
  String password = '';
  String confirmPassword = '';

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
              onPressed: () => AppRouter.of(context).popWithResult(null),
              child: Text(
                FlutterI18n.translate(context, 'general.cancel'),
                style: AppTextTheme.manrope16Light.copyWith(
                  color: AppTheme.textPrimaryColor,
                ),
              ),
            ),
          ),
          backgroundColor: AppTheme.positiveColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SafeArea(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Personal Information',
                        style: AppTextTheme.manrope32Bold.copyWith(
                          color: AppTheme.accentColor,
                        ),
                      ),
                      const SizedBox(height: 70),
                      AppTextFormField(
                        hintText: 'First Name',
                        onChanged: (String value) {
                          setState(() {
                            fullName = value;
                          });
                        },
                      ),
                      AppTextFormField(
                        hintText: 'Last Name',
                        onChanged: (String value) {
                          setState(() {
                            fullName = value;
                          });
                        },
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        height: 68,
                        decoration: BoxDecoration(
                          color: AppTheme.textFieldBackgroundColor,
                          borderRadius: BorderRadius.circular(
                            16,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 6,
                            right: 21,
                            left: 21,
                            bottom: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Phone Number',
                                style: AppTextTheme.manrope14Light.copyWith(
                                  color: AppTheme.k,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    '+1 502-384-1845',
                                    style:
                                        AppTextTheme.manrope20Medium.copyWith(
                                      color: AppTheme.p,
                                    ),
                                  ),
                                  AppImagesTheme.fieldSuccessIcon,
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      AppTextFormField(
                        obscureText: true,
                        showObscureButton: true,
                        hintText:
                            FlutterI18n.translate(context, 'signIn.password'),
                        onChanged: (String value) {
                          setState(() {
                            password = value;
                          });
                        },
                      ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 4,
                              width: 4,
                              decoration: BoxDecoration(
                                color: AppTheme.accentColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            RichText(
                              text: TextSpan(
                                style: AppTextTheme.manrope14Medium.copyWith(
                                  color: AppTheme.accentColor,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '8-16 characters ',
                                  ),
                                  TextSpan(
                                    text: '(E.g: Ab12345678 )',
                                    style: TextStyle(
                                      color: AppTheme.heighlitedColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      AppTextFormField(
                        obscureText: true,
                        showObscureButton: true,
                        hintText: FlutterI18n.translate(
                          context,
                          'signIn.passwordConfirm',
                        ),
                        onChanged: (String value) {
                          setState(() {
                            password = value;
                          });
                        },
                      ),
                      // const Spacer(),
                      const SizedBox(
                        height: 200,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 14,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            CustomCheckBox(
                              value: radioValue,
                              negativeImage: AppImagesTheme.radioCheckBoxFalse,
                              positiveImage: AppImagesTheme.radioCheckBoxTrue,
                              onChanged: (bool value) {
                                setState(() {
                                  radioValue = !radioValue;
                                });
                              },
                            ),
                            const SizedBox(width: 8),
                            RichText(
                              text: TextSpan(
                                style: AppTextTheme.manrope14Medium.copyWith(
                                  color: AppTheme.heighlitedColor,
                                ),
                                children: const <TextSpan>[
                                  TextSpan(
                                    text: 'Agree to  ',
                                  ),
                                  TextSpan(
                                    text: 'Terms & Conditions',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' & ',
                                  ),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: AppButton(
                          isDisabled: radioValue,
                          labelKey: FlutterI18n.translate(
                              context, 'personalInformation.buttonText'),
                          textStyle: AppTextTheme.manrope20Medium.copyWith(
                            color: AppTheme.positiveColor,
                          ),
                          backgroundColor: AppTheme.grassColor,
                          onTap: () {
                            BlocProvider.of<PersonalInformationBloc>(context)
                                .add(
                              RegisterUser(
                                user: User(
                                  username: fullName,
                                  password: password,
                                  phoneNumber: '+995591506787',
                                ),
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
          ),
        );
      },
    );
  }
}
