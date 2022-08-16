import 'package:core/core.dart';
import 'package:domain/domain.dart' as domain;

class DeeplinkRepositoryImpl implements domain.DeeplinkRepository {
  final FirebaseConfigHelper _firebaseConfigHelper;

  late BehaviorSubject<domain.DeeplinkIntent?> _deeplinkStreamController;

  DeeplinkRepositoryImpl({
    required FirebaseConfigHelper firebaseConfigHelper,
  }) : _firebaseConfigHelper = firebaseConfigHelper {
    _deeplinkStreamController =
        BehaviorSubject<domain.DeeplinkIntent?>.seeded(null);
  }

  @override
  Stream<domain.DeeplinkIntent?> get deeplinkStream =>
      _deeplinkStreamController.stream;

  @override
  domain.DeeplinkIntent? get lastDeeplink => _deeplinkStreamController.value;

  @override
  Future<void> configure() async {
    addDeeplinkListener();
    await getInitialLink();
  }

  @override
  void resetLastDeeplink() {
    _deeplinkStreamController.add(null);
  }

  @override
  Future<domain.DeeplinkIntent?> getInitialLink() async {
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();

    domain.DeeplinkIntent? intent;
    if (initialLink != null) {
      intent = domain.DeeplinkIntent.fromUri(initialLink.link);
      _deeplinkStreamController.add(intent);
    }

    return intent;
  }

  void addDeeplinkListener() {
    FirebaseDynamicLinks.instance.onLink.listen(
      (PendingDynamicLinkData dynamicLinkData) {
        final domain.DeeplinkIntent intent =
            domain.DeeplinkIntent.fromUri(dynamicLinkData.link);
        _deeplinkStreamController.add(intent);
      },
    );
  }

  @override
  Future<Uri> createDeeplink(domain.CreateDeeplinkPayload payload) async {
    final DynamicLinkParameters dynamicLinkParams =
        _firebaseConfigHelper.dynamicLinkParameters(payload.url);

    final ShortDynamicLink shortDeepLink =
        await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);

    return shortDeepLink.shortUrl;
  }
}
