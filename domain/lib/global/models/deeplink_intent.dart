part of global;

class DeeplinkIntent extends Equatable {
  final DeeplinkDestination destination;
  final Uri link;

  Map<String, String> get queryParams => link.queryParameters;

  const DeeplinkIntent({
    required this.destination,
    required this.link,
  });

  factory DeeplinkIntent.fromUri(Uri uri) {
    final String path = uri.path.toLowerCase();

    if (path.contains(DeeplinkDestination.invite.path)) {
      return DeeplinkIntent.invitation(uri);
    }

    throw Exception('not supported deeplink');
  }

  factory DeeplinkIntent.invitation(
    Uri uri,
  ) {
    return DeeplinkIntent(
      destination: DeeplinkDestination.invite,
      link: uri,
    );
  }

  @override
  List<Object> get props => <Object>[
        destination,
        link,
      ];
}
