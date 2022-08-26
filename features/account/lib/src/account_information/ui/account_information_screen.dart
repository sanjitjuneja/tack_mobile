import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import '../bloc/account_information_bloc.dart';
import 'account_information_form.dart';

class AccountInformationScreen extends StatelessWidget {
  const AccountInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.secondaryBackgroundColor,
      navigationBar: AppNavigationBar(
        backgroundColor: AppTheme.secondaryBackgroundColor,
        actions: <Widget>[
          OpacityOnTapContainer(
            onTap: () => _onEditButtonPressed(context),
            child: AppIconsTheme.editPencil(
              color: AppTheme.iconPrimaryColor,
            ),
          ),
        ],
      ),
      child: const SafeArea(
        child: AccountInformationForm(),
      ),
    );
  }

  void _onEditButtonPressed(BuildContext context) {
    BlocProvider.of<AccountInformationBloc>(context).add(
      const ChangeProfileAction(),
    );
  }
}
