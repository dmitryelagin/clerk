import 'interfaces_private.dart';
import 'store_settings.dart';
import 'types_public.dart';

class StateManagerNull<M extends Object, A extends Object>
    implements StateManager<M, A> {
  StateManagerNull(this._settings);

  final StoreSettings _settings;

  @override
  Stream<M> get onChange => _settings.onListenChangeFailed();

  @override
  Stream<M> get onAfterChanges => _settings.onListenChangeFailed();

  @override
  V evaluate<V>(Selector<M, V> select) => _settings.onEvaluationFailed(M, V);

  @override
  V evaluateUnary<V, X>(SelectorUnary<M, V, X> select, X x) =>
      _settings.onEvaluationFailed(M, V, x);

  @override
  V evaluateBinary<V, X, Y>(SelectorBinary<M, V, X, Y> select, X x, Y y) =>
      _settings.onEvaluationFailed(M, V, x, y);

  @override
  void assign<V>(Writer<A, V> write) {
    _settings.onAssignmentFailed<V>(A, V);
  }

  @override
  void assignUnary<V, X>(WriterUnary<A, V, X> write, X x) {
    _settings.onAssignmentFailed<V>(A, V, x);
  }

  @override
  void assignBinary<V, X, Y>(WriterBinary<A, V, X, Y> write, X x, Y y) {
    _settings.onAssignmentFailed<V>(A, V, x, y);
  }
}
