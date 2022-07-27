part of tacks;

class TackUserContacts extends Equatable {
  final String? phoneNumber;

  const TackUserContacts({
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => <Object?>[
        phoneNumber,
      ];
}
