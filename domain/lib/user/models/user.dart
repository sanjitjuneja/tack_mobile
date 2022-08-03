part of user;

class User {
  final int id;
  final double balance;
  final String firstName;
  final String lastName;
  final int? activeGroup;
  final String phoneNumber;

  User({
    required this.id,
    required this.balance,
    required this.firstName,
    required this.lastName,
    required this.activeGroup,
    required this.phoneNumber,
  });
}
