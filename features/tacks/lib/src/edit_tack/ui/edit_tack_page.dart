import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import 'package:tacks/src/edit_tack/bloc/edit_tack_bloc.dart';
import 'package:tacks/src/edit_tack/ui/edit_tack_screen.dart';

class EditTack {
  static const String routeName = '/editTack';

  static Page<bool> page(Tack tack) {
    return _EditTackPage(tack: tack);
  }
}

class _EditTackPage extends Page<bool> {
  final Tack tack;

  @override
  String get name => EditTack.routeName;

  const _EditTackPage({
    required this.tack,
  });

  @override
  Route<bool> createRoute(BuildContext context) {
    return CupertinoPageRoute<bool>(
      settings: this,
      builder: (_) => BlocProvider<EditTackBloc>(
        create: (_) {
          return EditTackBloc(
            tack: tack,
            appRouter: AppRouter.of(context),
            editTackUseCase: appLocator.get<EditTackUseCase>(),
          );
        },
        child: const EditTackScreen(),
      ),
    );
  }
}
