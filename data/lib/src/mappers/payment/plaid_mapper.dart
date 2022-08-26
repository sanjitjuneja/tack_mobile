part of mappers;

class PlaidMapper implements Mapper<PlaidEntity, domain.Plaid> {
  const PlaidMapper();

  @override
  domain.Plaid fromEntity(PlaidEntity entity) {
    return domain.Plaid(
      linkToken: entity.linkToken,
    );
  }

  @override
  PlaidEntity toEntity(domain.Plaid item) {
    return PlaidEntity(
      linkToken: item.linkToken,
    );
  }
}
