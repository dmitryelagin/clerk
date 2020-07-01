import 'provider.dart';
import 'types.dart';

class SingletonProvider<T> implements Provider<T> {
  SingletonProvider(
    this._create, {
    ResetInstance<T> onReset,
    bool isLazy = false,
  })  : _onReset = onReset,
        _isLazy = isLazy;

  final CreateInstance<T> _create;
  final ResetInstance<T> _onReset;
  final bool _isLazy;

  T _instance;

  @override
  bool get isLazy => _isLazy;

  bool get _canReset => _onReset != null && _instance != null;

  @override
  T getInstance() => _instance ??= _create();

  @override
  void reset() {
    if (_canReset) _onReset(_instance);
    _instance = null;
  }
}
