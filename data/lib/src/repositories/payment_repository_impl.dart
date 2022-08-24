import 'dart:async';

import 'package:core/core.dart';
import 'package:data/src/entities/entities.dart';
import 'package:domain/domain.dart' as domain;
import '../../data.dart';

class PaymentRepositoryImpl implements domain.PaymentRepository {
  final ApiProvider _apiProvider;
  final AppConfig _appConfig;

  PaymentRepositoryImpl({
    required ApiProvider apiProvider,
    required AppConfig appConfig,
  })  : _apiProvider = apiProvider,
        _appConfig = appConfig {
    Stripe.publishableKey = _appConfig.stripeKey;
  }

  @override
  Future<SetupIntent> addCard(
    domain.AddCardPayload payload,
  ) async {
    final domain.PaymentSetupIntent setupIntent =
        await _apiProvider.fetchSetupIntent(
      request: const AddCardRequest(),
    );

    final SetupIntent setupIntentResult =
        await Stripe.instance.confirmSetupIntent(
      setupIntent.clientSecret,
      const PaymentMethodParams.card(
        paymentMethodData: PaymentMethodData(),
      ),
    );

    return setupIntentResult;
  }

  @override
  Future<List<domain.BankAccount>?> addBankAccount(
    domain.AddBankAccountPayload payload,
  ) async {
    final Completer<List<domain.BankAccount>?> completer =
        Completer<List<domain.BankAccount>?>();

    final domain.Plaid plaidEntity = await _apiProvider.fetchPlaidEntity(
      request: const AddBankAccountRequest(),
    );
    final LinkConfiguration configuration = LinkTokenConfiguration(
      token: plaidEntity.linkToken,
    );

    PlaidLink.onSuccess(
      (publicToken, metadata) async {
        try {
          final List<domain.BankAccount> bankAccounts =
              await _apiProvider.getAddedBankAccounts(
            request: GetAddedBankAccountRequest(
              publicToken: publicToken,
            ),
          );
          completer.complete(bankAccounts);
        } catch (e) {
          completer.complete(null);
        }
      },
    );

    PlaidLink.onExit(
      (error, metadata) {
        completer.complete(null);
      },
    );

    PlaidLink.open(configuration: configuration);

    return completer.future;
  }
}
