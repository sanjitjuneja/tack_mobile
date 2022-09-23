part of tacks;

class FetchTackPayload with EquatableMixin {
  final int id;

  const FetchTackPayload({
    required this.id,
  });

  @override
  List<Object?> get props => <Object?>[
        id,
      ];
}
