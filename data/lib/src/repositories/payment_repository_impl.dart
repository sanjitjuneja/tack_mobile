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
              await _apiProvider.fetchPlaidBankAccounts(
            request: FetchPlaidBankAccountsRequest(
              publicToken: publicToken,
            ),
          );
          completer.complete(bankAccounts);
        } catch (error) {
          completer.completeError(error);
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
  Future<List<domain.ConnectedBankAccount>> fetchConnectedBankAccounts(
    domain.FetchConnectedBankAccountsPayload payload,
  ) async {
    final List<domain.ConnectedBankAccount> bankAccounts =
        await _apiProvider.fetchConnectedBankAccounts(
      request: const FetchConnectedBankAccountsRequest(),
    );

    return bankAccounts;
  }

  @override
  Future<List<domain.ConnectedCard>> fetchConnectedCards(
    domain.FetchConnectedCardsPayload payload,
  ) async {
    final List<domain.ConnectedCard> cards =
        await _apiProvider.fetchConnectedCards(
      request: const FetchConnectedCardsRequest(),
    );

    return cards;
  }

  @override
  Future<bool> fetchIsApplePaySupported(
    domain.FetchIsApplePaySupportedPayload payload,
  ) async {
    final bool isApplePaySupported =
        await Stripe.instance.checkApplePaySupport();

    return isApplePaySupported;
  }

  @override
  Future<bool> fetchIsGooglePaySupported(
    domain.FetchIsGooglePaySupportedPayload payload,
  ) async {
    final bool isGooglePaySupported =
        await Stripe.instance.isGooglePaySupported(
      const IsGooglePaySupportedParams(),
    );

    return isGooglePaySupported;
  }

  @override
  Future<void> removePaymentMethod(
    domain.RemovePaymentMethodPayload payload,
  ) async {
    await _apiProvider.removePaymentMethod(
      request: RemovePaymentMethodRequest(
        paymentType: payload.paymentMethodType.name,
        paymentMethodId: payload.paymentMethodId,
      ),
    );
  }

  @override
  Future<void> setPrimaryPaymentMethod(
    domain.SetPrimaryPaymentMethodPayload payload,
  ) async {
    await _apiProvider.setPrimaryPaymentMethod(
      request: SetPrimaryPaymentMethodRequest(
        paymentType: payload.paymentMethodType.name,
        paymentMethodId: payload.paymentMethodId,
      ),
    );
  }

  @override
  Future<domain.Fee> fetchFee(
    domain.FetchFeePayload payload,
  ) async {
    final domain.Fee fee = await _apiProvider.fetchFee(
      request: const FetchFeeRequest(),
    );

    return fee;
  }
}
