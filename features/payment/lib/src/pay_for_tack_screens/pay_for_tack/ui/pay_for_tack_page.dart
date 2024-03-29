import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import '../bloc/pay_for_tack_bloc.dart';
import 'pay_for_tack_screen.dart';

class PayForTackFeature {
  static const String routeName = '/payForTack';

  static Page<void> page({
    required Offer offer,
    required double tackPrice,
  }) {
    return PayForTackPage(
      offer: offer,
      tackPrice: tackPrice,
    );
  }
}

class PayForTackPage extends Page<void> {
  final Offer offer;
  final double tackPrice;

  @override
  String get name => PayForTackFeature.routeName;

  const PayForTackPage({
    required this.offer,
    required this.tackPrice,
  });

  @override
  Route<void> createRoute(BuildContext context) {
    return CupertinoPageRoute<void>(
      settings: this,
      builder: (_) {
        return BlocProvider<PayForTackBloc>(
          create: (_) {
            return PayForTackBloc(
              appRouter: appLocator.get<AppRouterDelegate>(),
              fetchConnectedBankAccountsUseCase:
                  appLocator.get<FetchConnectedBankAccountsUseCase>(),
              fetchConnectedCardsUseCase:
                  appLocator.get<FetchConnectedCardsUseCase>(),
              fetchIsApplePaySupportedUseCase:
                  appLocator.get<FetchIsApplePaySupportedUseCase>(),
              fetchIsGooglePaySupportedUseCase:
                  appLocator.get<FetchIsGooglePaySupportedUseCase>(),
              getUserBalanceUseCase: appLocator.get<GetUserBalanceUseCase>(),
              observeUserBalanceUseCase:
                  appLocator.get<ObserveUserBalanceUseCase>(),
              fetchUserBalanceUseCase:
                  appLocator.get<FetchUserBalanceUseCase>(),
              handleDwollaDepositUseCase:
                  appLocator.get<HandleDwollaDepositUseCase>(),
              handleStripeDepositUseCase:
                  appLocator.get<HandleStripeDepositUseCase>(),
              fetchFeeUseCase: appLocator.get<FetchFeeUseCase>(),
              offer: offer,
              tackPrice: tackPrice,
              acceptOfferUseCase: appLocator.get<AcceptOfferUseCase>(),
            );
          },
          child: const PayForTackScreen(),
        );
      },
    );
  }
}
