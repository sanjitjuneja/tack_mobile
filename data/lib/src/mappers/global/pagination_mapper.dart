part of mappers;

class PaginationMapper<S, C extends IdentifiableMixin>
    extends Mapper<PaginationEntity<S>, domain.PaginationModel<C>> {
  final Mapper<S, C> mapper;

  const PaginationMapper({
    required this.mapper,
  });

  @override
  domain.PaginationModel<C> fromEntity(PaginationEntity<S> entity) {
    return domain.PaginationModel<C>(
      count: entity.count,
      previous: entity.previous,
      next: entity.next,
      results: mapper.fromList(entity.results),
    );
  }

  @override
  PaginationEntity<S> toEntity(domain.PaginationModel<C> item) {
    return PaginationEntity<S>(
      count: item.count,
      previous: item.previous,
      next: item.next,
      results: mapper.toList(item.results),
    );
  }
}
