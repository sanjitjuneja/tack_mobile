part of mappers;

class AppPaymentMethodMapper
    implements Mapper<AppPaymentMethodEntity, domain.AppPaymentMethod> {
  const AppPaymentMethodMapper();

  @override
  domain.AppPaymentMethod fromEntity(AppPaymentMethodEntity entity) {
    switch (entity) {
      case AppPaymentMethodEntity.tackBalance:
        return domain.AppPaymentMethod.tackBalance;
      case AppPaymentMethodEntity.stripe:
        return domain.AppPaymentMethod.stripe;
      case AppPaymentMethodEntity.dwolla:
        return domain.AppPaymentMethod.dwolla;
    }
  }

  @override
  AppPaymentMethodEntity toEntity(domain.AppPaymentMethod item) {
    switch (item) {
      case domain.AppPaymentMethod.tackBalance:
        return AppPaymentMethodEntity.tackBalance;
      case domain.AppPaymentMethod.stripe:
        return AppPaymentMethodEntity.stripe;
      case domain.AppPaymentMethod.dwolla:
        return AppPaymentMethodEntity.dwolla;
    }
  }
}
