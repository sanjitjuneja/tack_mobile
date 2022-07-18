import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:forgot_password/bloc/forgot_password_state.dart';
import 'package:navigation/navigation.dart';

import 'bloc/forgot_password_bloc.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

bool isConnected = false;

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      builder: (BuildContext context, ForgotPasswordState state) {
        return CupertinoPageScaffold(
          backgroundColor: AppTheme.positiveColor,
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Enter New Password',
                  style: AppTextTheme.manrope32Bold.copyWith(
                    color: AppTheme.accentColor,
                  ),
                ),
                const SizedBox(height: 52),
                AppTextFormField(
                  obscureText: true,
                  showObscureButton: true,
                  hintText: 'New Password',
                  onChanged: (String newText) {},
                ),
                const SizedBox(height: 12),
                AppTextFormField(
                  obscureText: true,
                  showObscureButton: true,
                  hintText: 'Confirm New Password',
                  onChanged: (String newText) {},
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 47),
                  child: AppButton(
                    labelKey: 'forgotPassword.buttonText',
                    textStyle: AppTextTheme.manrope20Medium.copyWith(
                      color: AppTheme.positiveColor,
                    ),
                    backgroundColor: AppTheme.grassColor,
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
