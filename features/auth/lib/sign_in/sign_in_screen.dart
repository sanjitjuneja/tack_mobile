import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

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
        return CupertinoPageScaffold(
          backgroundColor: AppTheme.positiveColor,
          navigationBar: AppNavigationBar(
            backgroundColor: AppTheme.primaryColor,
            withResult: true,
          ),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: FocusScope.of(context).unfocus,
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
                      // LengthLimitingTextInputFormatter(11),
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
                        onTap: _onForgotPasswordButtonPressed,
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
                    height: 68,
                    isEnabled: state.isDataValid,
                    backgroundColor: AppTheme.grassColor,
                    disabledBackgroundColor: AppTheme.buttonDisabledColor,
                    disabledTextStyle: AppTextTheme.manrope20Medium.copyWith(
                      color: AppTheme.textHeavyHintColor,
                    ),
                    textStyle: AppTextTheme.manrope20Medium.copyWith(
                      color: AppTheme.positiveColor,
                    ),
                    borderRadius: BorderRadius.circular(35),
                    text: FlutterI18n.translate(
                      context,
                      'signIn.signIn',
                    ),
                    onPressed: _onSignInButtonPressed,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _onSignInButtonPressed() {
    BlocProvider.of<SignInBloc>(context).add(
      SignIn(
        password: password,
        phoneNumber: phoneNumber,
      ),
    );
  }

  void _onForgotPasswordButtonPressed() {
    BlocProvider.of<SignInBloc>(context).add(
      RouteToForgotPassword(),
    );
  }
}
