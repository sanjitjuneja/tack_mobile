part of payment;

class ConnectedBankAccount extends Equatable {
  final String id;
  final String bankName;
  final String status;
  final String type;
  final String bankAccountType;
  final List<String> channels;

  const ConnectedBankAccount({
    required this.id,
    required this.bankName,
    required this.status,
    required this.type,
    required this.bankAccountType,
    required this.channels,
  });

  @override
  List<Object?> get props => <Object?>[
        id,
        bankName,
        status,
        type,
        bankAccountType,
        channels,
      ];
}