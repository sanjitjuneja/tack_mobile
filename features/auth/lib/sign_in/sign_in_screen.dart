import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:navigation/navigation.dart';

import 'bloc/sign_in_bloc.dart';
import 'bloc/sign_in_event.dart';
import 'bloc/sign_in_state.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String password = '';
  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (BuildContext context, state) {
        if (state is SignInContent) {
          return CupertinoPageScaffold(
            backgroundColor: AppTheme.positiveColor,
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
                      FlutterI18n.translate(
                        context,
                        'general.back',
                      ),
                      style: AppTextTheme.manrope16Light.copyWith(
                        color: AppTheme.textPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      FlutterI18n.translate(context, 'signIn.title'),
                      style: AppTextTheme.manrope32Bold.copyWith(
                        color: AppTheme.accentColor,
                      ),
                    ),
                    const SizedBox(height: 21),
                    AppTextFormField(
                      hintText: FlutterI18n.translate(context, 'signIn.phone'),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                      onChanged: (String value) {
                        setState(() {
                          phoneNumber = value;
                        });
                        BlocProvider.of<SignInBloc>(context).add(
                          UpdateData(
                            password: password,
                            phoneNumber: phoneNumber,
                          ),
                        );
                      },
                      errorText: state.errors?['phoneNumber'],
                    ),
                    const SizedBox(height: 14),
                    AppTextFormField(
                      obscureText: true,
                      showObscureButton: true,
                      hintText: FlutterI18n.translate(
                        context,
                        'signIn.password',
                      ),
                      onChanged: (String value) {
                        setState(() {
                          password = value;
                        });
                        BlocProvider.of<SignInBloc>(context).add(
                          UpdateData(
                            password: password,
                            phoneNumber: phoneNumber,
                          ),
                        );
                      },
                      errorText: state.errors?['password'],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: <Widget>[
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<SignInBloc>(context).add(
                              RouteToForgotPassword(),
                            );
                          },
                          child: Text(
                            FlutterI18n.translate(
                              context,
                              'signIn.forgotPassword',
                            ),
                            style: AppTextTheme.manrope14Medium.copyWith(
                              color: AppTheme.accentColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    RoundedCustomButton(
                      isEnabled: state.isDataValid,
                      backgroundColor: AppTheme.grassColor,
                      disabledBackgroundColor:
                          AppTheme.buttonDisabledLightColor,
                      disabledTextStyle: AppTextTheme.manrope20Medium.copyWith(
                        color: AppTheme.textHeavyHintColor,
                      ),
                      height: 68,
                      textStyle: AppTextTheme.manrope20Medium.copyWith(
                        color: AppTheme.positiveColor,
                      ),
                      borderRadius: BorderRadius.circular(35),
                      text: FlutterI18n.translate(
                        context,
                        'signIn.signIn',
                      ),
                      onPressed: () {
                        BlocProvider.of<SignInBloc>(context).add(
                          SignIn(
                            password: password,
                            phoneNumber: phoneNumber,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
