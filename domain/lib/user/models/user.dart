part of user;

class Customer {
  final int id;
  final double balance;
  final String firstName;
  final String lastName;
  final int activeGroup;
  final String phoneNumber;

  Customer({
    required this.id,
    required this.balance,
    required this.firstName,
    required this.lastName,
    required this.activeGroup,
    required this.phoneNumber,
  });
}
