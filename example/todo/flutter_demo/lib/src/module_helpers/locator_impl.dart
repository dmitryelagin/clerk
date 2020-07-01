import 'factory_provider.dart';
import 'injector.dart';
import 'injector_null.dart';
import 'locator.dart';
import 'provider.dart';
import 'singleton_provider.dart';
import 'types.dart';

class LocatorImpl extends Locator {
  LocatorImpl({Injector parent}) : _parent = parent ?? const InjectorNull();

  final Injector _parent;

  final _providersMap = <Type, Set<Provider>>{};

  @override
  bool get isEmpty => _providersMap.isEmpty && _parent.isEmpty;

  Iterable<Provider> get _providers =>
      [for (final providers in _providersMap.values) ...providers];

  @override
  T tryGet<T>() {
    final providers = _providersMap[T] ?? const {};
    if (providers?.isEmpty ?? true) return _parent.tryGet();
    final instance = providers.first.getInstance();
    return instance is T ? instance : null;
  }

  @override
  Iterable<T> getAll<T>() {
    final providers = _providersMap[T] ?? const {};
    final parentInstances = _parent.getAll<T>();
    if (providers?.isEmpty ?? true) return parentInstances;
    final instances = providers.map((provider) => provider.getInstance());
    return instances is Iterable<T>
        ? [...parentInstances, ...instances]
        : parentInstances;
  }

  @override
  void bindSingleton<T>(
    CreateInstance<T> create, {
    ResetInstance<T> onReset,
    bool isLazy = false,
  }) {
    bind(SingletonProvider(create, onReset: onReset, isLazy: isLazy));
  }

  @override
  void bindFactory<T>(CreateInstance<T> create, {ResetInstance<T> onReset}) {
    bind(FactoryProvider(create, onReset: onReset));
  }

  @override
  void bind<T>(Provider<T> provider) {
    _providersMap[T] = (_providersMap[T] ?? {})..add(provider);
  }

  void initialize() {
    for (final provider in _providers) {
      if (!provider.isLazy) provider.getInstance();
    }
  }

  void reset() {
    for (final provider in _providers) {
      provider.reset();
    }
    _providersMap.clear();
  }
}
