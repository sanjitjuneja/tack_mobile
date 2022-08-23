import 'package:core/core.dart';
import 'package:domain/domain.dart' as domain;
import '../../data.dart';
import '../entities/payment/payment.dart';

class PaymentRepositoryImpl implements domain.PaymentRepository {
  final ApiProvider _apiProvider;

  PaymentRepositoryImpl({
    required ApiProvider apiProvider,
  }) : _apiProvider = apiProvider;

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
