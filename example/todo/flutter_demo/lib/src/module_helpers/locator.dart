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
  void registerSingleton<T>(
    CreateInstance<T> create, {
    ResetInstance<T> onReset,
  }) =>
      register(SingletonProvider(create, onReset: onReset));

  @override
  void registerFactory<T>(
    CreateInstance<T> create, {
    ResetInstance<T> onReset,
  }) =>
      register(FactoryProvider(create, onReset: onReset));

  @override
  void registerMimic<T, S extends T>() => register(MimicProvider<T, S>());

  void reset() {
    for (final provider in _providers.values) {
      provider.reset();
    }
    _providers.clear();
  }
}
