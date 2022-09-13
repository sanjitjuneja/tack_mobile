import 'package:domain/domain.dart';

class RunnerTacksState {
  final List<RunnerTack> results;
  final bool isLoading;

  bool get hasData => results.isNotEmpty;

  const RunnerTacksState({
    List<RunnerTack>? results,
    this.isLoading = false,
  }) : results = results ?? const <RunnerTack>[];

  RunnerTacksState _withSorting({
    required List<RunnerTack> results,
    bool isLoading = false,
  }) {
    return RunnerTacksState(
      results: results..sort(),
      isLoading: isLoading,
    );
  }

  RunnerTacksState _withoutSorting({
    required List<RunnerTack> results,
    bool isLoading = false,
  }) {
    return RunnerTacksState(
      results: results,
      isLoading: isLoading,
    );
  }

  RunnerTacksState copyWith({
    List<RunnerTack>? results,
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

  RunnerTacksState addItem({
    required RunnerTack item,
  }) {
    final int index = results.indexWhere(
      (element) => element.itemId == item.itemId,
    );

    if (index != -1) return this;

    return _withSorting(
      results: <RunnerTack>[
        item,
        ...results,
      ],
    );
  }

  RunnerTacksState updateItem({
    required RunnerTack item,
  }) {
    final int index = results.indexWhere(
      (element) => element.itemId == item.itemId,
    );

    if (index == -1) return this;

    final List<RunnerTack> items = <RunnerTack>[...results];
    items[index] = item;

    return _withSorting(
      results: items,
    );
  }

  RunnerTacksState removeItem({
    required int itemId,
  }) {
    final int index = results.indexWhere(
      (element) => element.itemId == itemId,
    );

    if (index == -1) return this;

    return _withoutSorting(
      results: <RunnerTack>[
        ...results,
      ]..removeAt(index),
    );
  }
}
