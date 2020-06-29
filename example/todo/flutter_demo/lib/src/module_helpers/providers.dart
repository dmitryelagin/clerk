import 'interfaces.dart';
import 'types.dart';

class SingletonProvider<T> implements Provider<T> {
  SingletonProvider(this._create, {ResetInstance<T> onReset})
      : _onReset = onReset;

  final CreateInstance<T> _create;
  final ResetInstance<T> _onReset;

  T _instance;

  bool get _canReset => _onReset != null && _instance != null;

  @override
  T getInstance(ResolveInstance resolve) => _instance ??= _create(resolve);

  @override
  void reset() {
    if (_canReset) _onReset(_instance);
    _instance = null;
  }
}

class FactoryProvider<T> implements Provider<T> {
  FactoryProvider(this._create, {ResetInstance<T> onReset})
      : _onReset = onReset;

  final CreateInstance<T> _create;
  final ResetInstance<T> _onReset;

  T _instance;

  bool get _canReset => _onReset != null && _instance != null;

  @override
  T getInstance(ResolveInstance resolve) {
    if (_canReset) _onReset(_instance);
    return _instance = _create(resolve);
  }

  @override
  void reset() {
    if (_canReset) _onReset(_instance);
    _instance = null;
  }
}

class MimicProvider<T, S extends T> implements Provider<T> {
  @override
  T getInstance(ResolveInstance resolve) => resolve<S>();

  @override
  void reset() {}
}
