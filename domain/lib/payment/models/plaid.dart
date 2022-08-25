part of payment;

class Plaid extends Equatable {
  final String linkToken;

  const Plaid({
    required this.linkToken,
  });

  @override
  List<Object?> get props => <Object>[linkToken];
}
