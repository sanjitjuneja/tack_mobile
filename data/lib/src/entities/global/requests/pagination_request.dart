part of global_entities;

class PaginationRequest {
  static const String _lastObjectIdKey = 'last_object';

  final int? lastObjectId;
  final Map<String, String>? _queryParameters;

  Map<String, String>? get queryParameters {
    if (_queryParameters == null) return null;

    final Map<String, String> params = Map<String, String>.from(
      _queryParameters!,
    );
    if (lastObjectId != null) {
      params[_lastObjectIdKey] = lastObjectId.toString();
    }

    return params;
  }

  const PaginationRequest({
    required this.lastObjectId,
    required Map<String, String>? queryParameters,
  }) : _queryParameters = queryParameters;
}
