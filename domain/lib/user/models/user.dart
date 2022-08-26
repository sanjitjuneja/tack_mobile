part of user;

class User {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final DateTime? birthDate;
  final String? profilePicture;
  final double rating;
  final int tacksAmount;
  final String phoneNumber;
  final int? activeGroup;

  String get fullName => <String>[firstName, lastName].join(' ');

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.profilePicture,
    required this.rating,
    required this.tacksAmount,
    required this.phoneNumber,
    required this.activeGroup,
  });
}
