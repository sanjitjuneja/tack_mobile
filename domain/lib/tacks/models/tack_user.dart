part of tacks;

class TackUser extends Equatable {
  final int id;
  final String firstName;
  final String lastName;
  final double rating;
  final int tacksComplete;

  String get fullName => <String>[firstName, lastName].join(' ');

  const TackUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.rating,
    required this.tacksComplete,
  });

  @override
  List<Object?> get props => <Object?>[
        id,
        firstName,
        lastName,
        rating,
        tacksComplete,
      ];
}
