part of global;

class PaginationModel<T extends IdentifiableMixin> extends Equatable {
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

  PaginationModel<T> addItem({
    required T item,
  }) {
    final int index = results.indexWhere(
      (element) => element.itemId == item.itemId,
    );

    if (index != -1) return this;

    return PaginationModel(
      count: count + 1,
      previous: previous,
      next: next,
      results: <T>[
        item,
        ...results,
      ],
    );
  }

  PaginationModel<T> updateItem({
    required T item,
  }) {
    final int index = results.indexWhere(
      (element) => element.itemId == item.itemId,
    );

    if (index == -1) return this;

    final List<T> items = <T>[...results];
    items[index] = item;

    return PaginationModel(
      count: count,
      previous: previous,
      next: next,
      results: items,
    );
  }

  PaginationModel<T> removeItem({
    required int itemId,
  }) {
    final int index = results.indexWhere(
      (element) => element.itemId == itemId,
    );

    if (index == -1) return this;

    return PaginationModel(
      count: count - 1,
      previous: previous,
      next: next,
      results: <T>[
        ...results,
      ]..removeAt(index),
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
