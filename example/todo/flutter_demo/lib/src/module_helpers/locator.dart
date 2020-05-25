import 'injector.dart';
import 'providers.dart';
import 'types.dart';

class Locator implements Injector {
  final _providers = <Type, Provider<Object>>{};

  @override
  void mapSingleton<T>(CreateInstance<T> create) =>
      map(SingletonProvider(create));

  @override
  void mapFactory<T>(CreateInstance<T> create) => map(FactoryProvider(create));

  @override
  void mapMimic<T, S extends T>() => map(MimicProvider<T, S>());

  @override
  void map<T>(Provider<T> provider) {
    _providers[T] = provider;
  }

  T get<T>() {
    final instance = _providers[T].getInstance(get);
    return instance is T ? instance : null;
  }

  void clear() {
    _providers.clear();
  }
}
