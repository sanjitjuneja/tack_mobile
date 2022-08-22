part of global;

enum DeeplinkDestination {
  invite('/groups/invite/');

  final String path;

  const DeeplinkDestination(this.path);
}
