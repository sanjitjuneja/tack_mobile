import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'offline_form.dart';

class OfflineScreen extends StatelessWidget {
  final GetCurrentUserUseCase _getCurrentUserUseCase;

  const OfflineScreen({
    super.key,
    required GetCurrentUserUseCase getCurrentUserUseCase,
  }) : _getCurrentUserUseCase = getCurrentUserUseCase;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor: AppTheme.primaryBackgroundColor,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: CupertinoPageScaffold(
          backgroundColor: AppTheme.primaryBackgroundColor,
          navigationBar: AppNavigationBar(
            backgroundColor: AppTheme.primaryBackgroundColor,
            automaticallyImplyLeading: false,
            withMenu: true,
            isMenuReachable: false,
            middle: Align(
              alignment: Alignment.centerLeft,
              child: PageHeaderWithGroupWidget(
                titleKey: _getCurrentUserUseCase.execute(NoParams()).fullName,
                image: null,
              ),
            ),
          ),
          child: const OfflineForm(),
        ),
      ),
    );
  }
}
