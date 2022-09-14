import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import '../bloc/add_edit_tack_bloc.dart';
import 'add_edit_tack_screen.dart';

class AddEditTackFeature {
  static const String routeName = '/addEditTack';

  static Page<Tack?> addPage({TemplateTack? templateTack}) {
    return _AddEditTackPage(templateTack: templateTack, isAdd: true);
  }

  static Page<Tack?> editPage(Tack tack) {
    return _AddEditTackPage(tack: tack, isAdd: false);
  }
}

class _AddEditTackPage extends Page<Tack?> {
  final bool isAdd;
  final TemplateTack? templateTack;
  final Tack? tack;

  @override
  String get name => AddEditTackFeature.routeName;

  const _AddEditTackPage({
    required this.isAdd,
    this.templateTack,
    this.tack,
  });

  @override
  Route<Tack?> createRoute(BuildContext context) {
    return CupertinoPageRoute<Tack?>(
      settings: this,
      builder: (_) => BlocProvider<AddEditTackBloc>(
        create: (_) {
          return AddEditTackBloc(
            templateTack: templateTack,
            tack: tack,
            isAdd: isAdd,
            appRouter: AppRouter.of(context),
            getCurrentGroupUseCase: appLocator.get<GetCurrentGroupUseCase>(),
            createTackUseCase: appLocator.get<CreateTackUseCase>(),
            editTackUseCase: appLocator.get<EditTackUseCase>(),
          );
        },
        child: const AddEditTackScreen(),
      ),
    );
  }
}
