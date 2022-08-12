part of global;

class PaginationModel<T> extends Equatable {
  final int count;
  final Uri? previous;
  final Uri? next;
  final DateTime lastUpdated;
  final List<T> results;

  bool get canLoadMore => next != null;

  bool get hasData => results.isNotEmpty;

  PaginationModel({
    required this.count,
    required this.previous,
    required this.next,
    List<T>? results,
  })  : lastUpdated = DateTime.now(),
        results = results ?? <T>[];

  factory PaginationModel.empty() {
    return PaginationModel(
      count: 0,
      previous: null,
      next: null,
    );
  }

  PaginationModel<T> more({
    required PaginationModel<T> newPage,
  }) {
    return PaginationModel(
      count: newPage.count,
      previous: newPage.previous,
      next: newPage.next,
      results: <T>[
        ...results,
        ...newPage.results,
      ],
    );
  }

  @override
  List<Object?> get props => <Object?>[
        count,
        previous,
        next,
        lastUpdated,
        results,
      ];
}
