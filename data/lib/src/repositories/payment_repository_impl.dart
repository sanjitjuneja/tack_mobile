import 'dart:async';

import 'package:core/core.dart';
import '../entities/entities.dart';
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
  Future<List<domain.ConnectedBankAccount>?> addBankAccount(
    domain.AddBankAccountPayload payload,
  ) async {
    final Completer<List<domain.ConnectedBankAccount>?> completer =
        Completer<List<domain.ConnectedBankAccount>?>();

    final domain.Plaid plaidEntity = await _apiProvider.fetchPlaidEntity(
      request: const AddBankAccountRequest(),
    );
    final LinkConfiguration configuration = LinkTokenConfiguration(
      token: plaidEntity.linkToken,
    );

    PlaidLink.onSuccess(
      (String publicToken, LinkSuccessMetadata metadata) async {
        try {
          final List<domain.ConnectedBankAccount> bankAccounts =
              await _apiProvider.getPlaidBankAccounts(
            request: GetPlaidBankAccountsRequest(
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
      (LinkError? error, LinkExitMetadata metadata) {
        completer.complete(null);
      },
    );

    PlaidLink.open(configuration: configuration);

    return completer.future;
  }

  @override
  Future<List<domain.ConnectedBankAccount>> getConnectedBankAccounts(
    domain.GetConnectedBankAccountsPayload payload,
  ) async {
    final List<domain.ConnectedBankAccount> bankAccounts =
        await _apiProvider.getConnectedBankAccounts(
      request: const GetConnectedBankAccountsRequest(),
    );

    return bankAccounts;
  }

  @override
  Future<List<domain.ConnectedCard>> getConnectedCards(
    domain.GetConnectedCardsPayload payload,
  ) async {
    final List<domain.ConnectedCard> cards =
        await _apiProvider.getConnectedCards(
      request: const GetConnectedCardsRequest(),
    );

    return cards;
  }
}
