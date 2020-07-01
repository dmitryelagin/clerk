import 'interfaces.dart';
import 'module.dart';
import 'module_null.dart';
import 'providers.dart';
import 'types.dart';

class LocatorImpl extends Module implements Locator {
  LocatorImpl({Module parent}) : _parent = parent ?? const ModuleNull();

  final Module _parent;

  final _providers = <Type, Set<Provider>>{};

  @override
  bool get isEmpty => _providers.isEmpty && _parent.isEmpty;

  @override
  T tryResolve<T>() {
    final providers = _providers[T] ?? const {};
    if (providers?.isEmpty ?? true) return _parent.tryResolve();
    final instance = providers.first.getInstance();
    return instance is T ? instance : null;
  }

  @override
  Iterable<T> resolveAll<T>() {
    final providers = _providers[T] ?? const {};
    final parentInstances = _parent.resolveAll<T>();
    if (providers?.isEmpty ?? true) return parentInstances;
    final instances = providers.map((provider) => provider.getInstance());
    return instances is Iterable<T>
        ? [...parentInstances, ...instances]
        : parentInstances;
  }

  @override
  void register<T>(Provider<T> provider) {
    _providers[T] = (_providers[T] ?? {})..add(provider);
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

  void reset() {
    final providers = [
      for (final providers in _providers.values) ...providers,
    ];
    for (final provider in providers) {
      provider.reset();
    }
    _providers.clear();
  }
}
