import 'injector.dart';
import 'injector_null.dart';
import 'interfaces.dart';
import 'providers.dart';
import 'types.dart';

class LocatorImpl extends Locator {
  LocatorImpl({Injector parent}) : _parent = parent ?? const InjectorNull();

  final Injector _parent;

  final _providers = <Type, Set<Provider>>{};

  @override
  bool get isEmpty => _providers.isEmpty && _parent.isEmpty;

  @override
  T tryGet<T>() {
    final providers = _providers[T] ?? const {};
    if (providers?.isEmpty ?? true) return _parent.tryGet();
    final instance = providers.first.getInstance();
    return instance is T ? instance : null;
  }

  @override
  Iterable<T> getAll<T>() {
    final providers = _providers[T] ?? const {};
    final parentInstances = _parent.getAll<T>();
    if (providers?.isEmpty ?? true) return parentInstances;
    final instances = providers.map((provider) => provider.getInstance());
    return instances is Iterable<T>
        ? [...parentInstances, ...instances]
        : parentInstances;
  }

  @override
  void bindSingleton<T>(CreateInstance<T> create, {ResetInstance<T> onReset}) {
    bind(SingletonProvider(create, onReset: onReset));
  }

  @override
  void bindFactory<T>(CreateInstance<T> create, {ResetInstance<T> onReset}) {
    bind(FactoryProvider(create, onReset: onReset));
  }

  @override
  void bind<T>(Provider<T> provider) {
    _providers[T] = (_providers[T] ?? {})..add(provider);
  }

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
