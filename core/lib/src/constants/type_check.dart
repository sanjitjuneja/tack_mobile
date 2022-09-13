bool isNullableType<T>() => null is T;

bool isTypeExactType<T, CT>() => T == CT;

bool isTypeTypeOf<T, CT>() =>
    isTypeExactType<T, CT>() || isTypeExactType<T, CT?>();
