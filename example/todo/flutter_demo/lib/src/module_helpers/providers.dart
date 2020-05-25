import 'types.dart';

abstract class Provider<T> {
  T getInstance(GetInstance get);
}

class SingletonProvider<T> implements Provider<T> {
  SingletonProvider(this._create);

  final CreateInstance<T> _create;

  T _instance;

  @override
  T getInstance(GetInstance get) => _instance ??= _create(get);
}

class FactoryProvider<T> implements Provider<T> {
  FactoryProvider(this._create);

  final CreateInstance<T> _create;

  @override
  T getInstance(GetInstance get) => _create(get);
}

class MimicProvider<T, S extends T> implements Provider<T> {
  @override
  T getInstance(GetInstance get) => get<S>();
}
