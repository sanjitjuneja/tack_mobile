part of tacks;

class TackUser extends Equatable {
  final int id;
  final String firstName;
  final String lastName;
  final double rating;
  final int tacksComplete;
  final TackUserContacts contacts;

  String get fullName => <String>[firstName, lastName].join(' ');

  const TackUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.rating,
    required this.tacksComplete,
    required this.contacts,
  });

  @override
  List<Object?> get props => <Object?>[
        id,
        firstName,
        lastName,
        rating,
        tacksComplete,
        contacts,
      ];
}
