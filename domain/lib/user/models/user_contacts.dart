part of user;

class UserContacts extends Equatable {
  final String phoneNumber;
  final String email;

  const UserContacts({
    required this.phoneNumber,
    required this.email,
  });

  @override
  List<Object> get props => <Object>[
        phoneNumber,
        email,
      ];
}
