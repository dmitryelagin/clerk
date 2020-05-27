import 'interfaces.dart';
import 'providers.dart';
import 'types.dart';

class Locator implements Module, Injector {
  final _providers = <Type, Provider<Object>>{};

  @override
  T resolve<T>() {
    final instance = _providers[T].getInstance(resolve);
    return instance is T ? instance : null;
  }

  @override
  void register<T>(Provider<T> provider) {
    _providers[T] = provider;
  }

  @override
  void registerSingleton<T>(CreateInstance<T> create) =>
      register(SingletonProvider(create));

  @override
  void registerFactory<T>(CreateInstance<T> create) =>
      register(FactoryProvider(create));

  @override
  void registerMimic<T, S extends T>() => register(MimicProvider<T, S>());

  void reset() {
    _providers.clear();
  }
}
