import 'package:domain/domain.dart';

class TackerTacksState {
  final List<Tack> tacks;
  final bool isLoading;
  final bool canLoadMore;

  bool get hasData => tacks.isNotEmpty;

  const TackerTacksState({
    List<Tack>? tacks,
    this.isLoading = false,
    this.canLoadMore = true,
  }) : tacks = tacks ?? const <Tack>[];

  TackerTacksState copyWith({
    List<Tack>? tacks,
    bool? isLoading,
    bool? canLoadMore,
  }) {
    return TackerTacksState(
      tacks: tacks ?? this.tacks,
      isLoading: isLoading ?? false,
      canLoadMore: canLoadMore ?? this.canLoadMore,
    );
  }
}
