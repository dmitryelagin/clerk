import 'interfaces.dart';
import 'types.dart';

class SingletonProvider<T> implements Provider<T> {
  SingletonProvider(this._create);

  final CreateInstance<T> _create;

  T _instance;

  @override
  T getInstance(ResolveInstance resolve) => _instance ??= _create(resolve);
}

class FactoryProvider<T> implements Provider<T> {
  FactoryProvider(this._create);

  final CreateInstance<T> _create;

  @override
  T getInstance(ResolveInstance resolve) => _create(resolve);
}

class MimicProvider<T, S extends T> implements Provider<T> {
  @override
  T getInstance(ResolveInstance resolve) => resolve<S>();
}
