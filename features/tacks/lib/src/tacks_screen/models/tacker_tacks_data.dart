import 'package:domain/domain.dart';

class TackerTacksState {
  final List<Tack> results;
  final bool isLoading;

  bool get hasData => results.isNotEmpty;

  const TackerTacksState({
    List<Tack>? results,
    this.isLoading = false,
  }) : results = results ?? const <Tack>[];

  TackerTacksState _withSorting({
    required List<Tack> results,
    bool isLoading = false,
  }) {
    return TackerTacksState(
      results: results..sort(),
      isLoading: isLoading,
    );
  }

  TackerTacksState _withoutSorting({
    required List<Tack> results,
    bool isLoading = false,
  }) {
    return TackerTacksState(
      results: results,
      isLoading: isLoading,
    );
  }

  TackerTacksState copyWith({
    List<Tack>? results,
    bool? isLoading,
  }) {
    final bool isLoadingResult = isLoading ?? false;

    if (results == null) {
      return _withoutSorting(
        results: this.results,
        isLoading: isLoadingResult,
      );
    }

    return _withSorting(
      results: results,
      isLoading: isLoadingResult,
    );
  }

  TackerTacksState addItem({
    required Tack item,
  }) {
    final int index = results.indexWhere(
      (element) => element.itemId == item.itemId,
    );

    if (index != -1) return this;

    return _withSorting(
      results: <Tack>[
        item,
        ...results,
      ],
    );
  }

  TackerTacksState updateItem({
    required Tack item,
  }) {
    final int index = results.indexWhere(
      (element) => element.itemId == item.itemId,
    );

    if (index == -1) return this;

    final List<Tack> items = <Tack>[...results];
    items[index] = item;

    return _withSorting(
      results: items,
    );
  }

  TackerTacksState removeItem({
    required int itemId,
  }) {
    final int index = results.indexWhere(
      (element) => element.itemId == itemId,
    );

    if (index == -1) return this;

    return _withoutSorting(
      results: <Tack>[
        ...results,
      ]..removeAt(index),
    );
  }
}
