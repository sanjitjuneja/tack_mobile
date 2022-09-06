part of payment;

class ConnectedBankAccount extends Equatable {
  final String id;
  final String bankName;
  final String status;
  final String type;
  final String bankAccountType;
  final String? imageUrl;
  final List<String> channels;
  final bool isPrimary;

  const ConnectedBankAccount({
    required this.id,
    required this.bankName,
    required this.status,
    required this.type,
    required this.bankAccountType,
    required this.imageUrl,
    required this.channels,
    required this.isPrimary,
  });

  @override
  List<Object?> get props => <Object?>[
        id,
        bankName,
        status,
        type,
        bankAccountType,
        imageUrl,
        channels,
        isPrimary,
      ];
}
