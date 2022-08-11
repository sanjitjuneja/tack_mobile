class Nonsense<T> {
  const Nonsense();

  Type call() => T;
}

const Nonsense<void> voidType = Nonsense<void>();

bool isVoid(Type type) => type == voidType();
