import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import 'bloc/sign_up_bloc.dart';
import 'bloc/sign_up_state.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (BuildContext context, state) {
        return CupertinoPageScaffold(
          backgroundColor: AppTheme.positiveColor,
          child: const SizedBox.shrink(),
        );
      },
    );
  }
}
