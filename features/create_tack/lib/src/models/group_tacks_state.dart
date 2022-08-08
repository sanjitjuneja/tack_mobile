import 'package:domain/domain.dart';

class GroupTacksState {
  final List<TemplateTack> tacks;
  final bool isLoading;
  final bool canLoadMore;

  bool get hasData => tacks.isNotEmpty;

  const GroupTacksState({
    List<TemplateTack>? tacks,
    this.isLoading = false,
    this.canLoadMore = false,
  }) : tacks = tacks ?? const <TemplateTack>[];

  GroupTacksState copyWith({
    List<TemplateTack>? tacks,
    bool? isLoading,
    bool? canLoadMore,
  }) {
    return GroupTacksState(
      tacks: tacks ?? this.tacks,
      isLoading: isLoading ?? false,
      canLoadMore: canLoadMore ?? this.canLoadMore,
    );
  }
}
