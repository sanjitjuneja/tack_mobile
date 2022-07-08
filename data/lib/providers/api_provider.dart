import 'package:data/providers/api_provider_base.dart';

class ApiProvider {
  final String _baseUrl;
  final ApiProviderBase _apiProviderBase;

  ApiProvider({
    required String baseUrl,
    required ApiProviderBase apiProviderBase,
  })  : _baseUrl = baseUrl,
        _apiProviderBase = apiProviderBase;
}
