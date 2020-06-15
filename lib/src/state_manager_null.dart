import 'interfaces_private.dart';
import 'store_settings.dart';
import 'types_public.dart';

class StateManagerNull<M extends Object?, A extends Object?>
    implements StateManager<M, A> {
  StateManagerNull(this._settings);

  final StoreSettings _settings;

  @override
  Stream<M> get onChange => _settings.onListenChangeFailed();

  @override
  Stream<M> get onAfterChanges => _settings.onListenChangeFailed();

  @override
  V read<V>(Read<M, V> fn) {
    return _settings.onReadFailed(M, V);
  }

  @override
  V readUnary<V, X>(ReadUnary<M, V, X> fn, X x) {
    return _settings.onReadFailed(M, V, x);
  }

  @override
  V readBinary<V, X, Y>(ReadBinary<M, V, X, Y> fn, X x, Y y) {
    return _settings.onReadFailed(M, V, x, y);
  }

  @override
  void write<V>(Write<A, V> fn) {
    _settings.onWriteFailed(A);
  }

  @override
  void writeUnary<V, X>(WriteUnary<A, V, X> fn, X x) {
    _settings.onWriteFailed(A, x);
  }

  @override
  void writeBinary<V, X, Y>(WriteBinary<A, V, X, Y> fn, X x, Y y) {
    _settings.onWriteFailed(A, x, y);
  }
}
