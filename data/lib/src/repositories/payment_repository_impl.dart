import 'package:core/core.dart';
import 'package:domain/domain.dart' as domain;
import '../../data.dart';
import '../entities/payment/payment.dart';

class PaymentRepositoryImpl implements domain.PaymentRepository {
  final ApiProvider _apiProvider;

  PaymentRepositoryImpl({
    required ApiProvider apiProvider,
  }) : _apiProvider = apiProvider {
    Stripe.publishableKey =
        'pk_test_51KYDDWHUDqRuKWfqG347VI2pG1CgnOApLRuoqeZZ4A0ZHBuOh5QapxVwJ9XLh5pZREboD3HyvbZl97VI1TlZsVqr00gRuftswA';
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
