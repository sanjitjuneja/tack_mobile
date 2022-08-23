import 'package:core/core.dart';
import 'package:domain/domain.dart' as domain;
import '../../data.dart';
import '../entities/payment/payment.dart';

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
  Future<SetupIntent> addCard() async {
    final SetupIntentEntity setupIntent =
        await _apiProvider.fetchSetupIntentClientSecret();

    final SetupIntent setupIntentResult =
        await Stripe.instance.confirmSetupIntent(
      setupIntent.clientSecret,
      const PaymentMethodParams.card(
        paymentMethodData: PaymentMethodData(),
      ),
    );

    return setupIntentResult;
  }
}
