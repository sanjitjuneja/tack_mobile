import 'package:domain/domain.dart';

class NearbyTacksState {
  final List<TemplateTack> tacks;
  final bool isLoading;
  final bool canLoadMore;

  bool get hasData => tacks.isNotEmpty;

  const NearbyTacksState({
    List<TemplateTack>? tacks,
    this.isLoading = false,
    this.canLoadMore = false,
  }) : tacks = tacks ?? const <TemplateTack>[];

  NearbyTacksState copyWith({
    List<TemplateTack>? tacks,
    bool? isLoading,
    bool? canLoadMore,
  }) {
    return NearbyTacksState(
      tacks: tacks ?? this.tacks,
      isLoading: isLoading ?? false,
      canLoadMore: canLoadMore ?? this.canLoadMore,
    );
  }
}
