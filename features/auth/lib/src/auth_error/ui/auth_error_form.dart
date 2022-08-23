import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import '../bloc/auth_error_bloc.dart';
import '../view_extensions/auth_error_to_view_extension.dart';

class AuthErrorForm extends StatelessWidget {
  const AuthErrorForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthErrorBloc, AuthErrorState>(
      builder: (_, AuthErrorState state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[
              Text(
                FlutterI18n.translate(context, state.errorType.titleKey),
                style: AppTextTheme.manrope32Bold.copyWith(
                  color: AppTheme.textPrimaryColor,
                ),
              ),
              const SizedBox(height: 44),
              AppImagesTheme.alertError,
              const Spacer(flex: 1),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  FlutterI18n.translate(
                    context,
                    state.errorType.descriptionKey,
                  ),
                  textAlign: TextAlign.center,
                  style: AppTextTheme.manrope14Medium
                      .copyWith(color: AppTheme.textHintColor),
                ),
              ),
              const Spacer(flex: 2),
              Row(
                children: <Widget>[
                  const Spacer(flex: 1),
                  Expanded(
                    flex: 5,
                    child: AppCircleButton(
                      labelKey: state.errorType.buttonLabelKey,
                      onTap: () => _onRedirectButtonPressed(context),
                    ),
                  ),
                  const Spacer(flex: 1),
                ],
              ),
              const SizedBox(height: 28),
            ],
          ),
        );
      },
    );
  }

  void _onRedirectButtonPressed(BuildContext context) {
    BlocProvider.of<AuthErrorBloc>(context).add(
      RedirectAction(context: context),
    );
  }
}
