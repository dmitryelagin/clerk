import 'provider.dart';
import 'types.dart';

class FactoryProvider<T> implements Provider<T> {
  FactoryProvider(
    this._create, {
    ResetInstance<T> onReset,
  }) : _onReset = onReset;

  final CreateInstance<T> _create;
  final ResetInstance<T> _onReset;

  T _instance;

  @override
  bool get isLazy => true;

  bool get _canReset => _onReset != null && _instance != null;

  @override
  T getInstance() {
    if (_canReset) _onReset(_instance);
    return _instance = _create();
  }

  @override
  void reset() {
    if (_canReset) _onReset(_instance);
    _instance = null;
  }
}
