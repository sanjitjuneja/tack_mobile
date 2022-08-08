import 'package:core/core.dart';
import 'package:dashboard/src/counter_offer_screen/bloc/counter_offer_bloc.dart';
import 'package:dashboard/src/counter_offer_screen/ui/counter_offer_screen.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

class CounterOffer {
  static const String routeName = '/counterOffer';

  static Page<bool?> page({
    required Tack tack,
  }) {
    return _CounterOfferPage(
      tack: tack,
    );
  }
}

class _CounterOfferPage extends Page<bool?> {
  final Tack tack;

  @override
  String get name => CounterOffer.routeName;

  const _CounterOfferPage({
    required this.tack,
  });

  @override
  Route<bool?> createRoute(BuildContext context) {
    return CupertinoPageRoute<bool?>(
      settings: this,
      builder: (_) => BlocProvider<CounterOfferBloc>(
        create: (_) {
          return CounterOfferBloc(
            appRouter: AppRouter.of(context),
            makeOfferUseCase: appLocator.get<MakeOfferUseCase>(),
            tack: tack,
          );
        },
        child: const CounterOfferScreen(),
      ),
    );
  }
}
