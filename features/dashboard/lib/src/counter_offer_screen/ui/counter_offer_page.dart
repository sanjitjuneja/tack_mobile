import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import '../bloc/counter_offer_bloc.dart';
import 'counter_offer_screen.dart';

class CounterOffer {
  static const String routeName = '/counterOffer';

  static Page<bool?> page({
    required GroupTack groupTack,
  }) {
    return _CounterOfferPage(
      groupTack: groupTack,
    );
  }
}

class _CounterOfferPage extends Page<bool?> {
  final GroupTack groupTack;

  @override
  String get name => CounterOffer.routeName;

  const _CounterOfferPage({
    required this.groupTack,
  });

  @override
  Route<bool?> createRoute(BuildContext context) {
    return CupertinoPageRoute<bool?>(
      settings: this,
      builder: (_) => BlocProvider<CounterOfferBloc>(
        create: (_) {
          return CounterOfferBloc(
            groupTack: groupTack,
            appRouter: AppRouter.of(context),
            makeOfferUseCase: appLocator.get<MakeOfferUseCase>(),
          );
        },
        child: const CounterOfferScreen(),
      ),
    );
  }
}
