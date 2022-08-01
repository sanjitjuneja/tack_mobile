import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import 'package:tacks/src/add_edit_tack/bloc/add_edit_tack_bloc.dart';
import 'package:tacks/src/add_edit_tack/ui/add_edit_tack_screen.dart';

class AddEditTack {
  static const String routeName = '/addEditTack';

  static Page<bool> page(
    Tack tack, {
    required bool isAdd,
  }) {
    return _AddEditTackPage(tack: tack, isAdd: isAdd);
  }

  static Page<bool> addPage({Tack? tack}) {
    return _AddEditTackPage(tack: tack, isAdd: true);
  }

  static Page<bool> editPage(Tack tack) {
    return _AddEditTackPage(tack: tack, isAdd: false);
  }
}

class _AddEditTackPage extends Page<bool> {
  final Tack? tack;
  final bool isAdd;

  @override
  String get name => AddEditTack.routeName;

  const _AddEditTackPage({
    required this.tack,
    required this.isAdd,
  });

  @override
  Route<bool> createRoute(BuildContext context) {
    return CupertinoPageRoute<bool>(
      settings: this,
      builder: (_) => BlocProvider<AddEditTackBloc>(
        create: (_) {
          return AddEditTackBloc(
            tack: tack,
            isAdd: isAdd,
            appRouter: AppRouter.of(context),
            editTackUseCase: appLocator.get<EditTackUseCase>(),
          );
        },
        child: const AddEditTackScreen(),
      ),
    );
  }
}
