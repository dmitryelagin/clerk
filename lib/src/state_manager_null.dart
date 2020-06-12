import 'interfaces_private.dart';
import 'types_public.dart';

class StateManagerNull<M extends Object, A extends Object>
    implements StateManager<M, A> {
  StateManagerNull(this._eventBus);

  final StoreFailureEventBusController _eventBus;

  @override
  Stream<M> get onChange {
    _eventBus.listenChangeFailed.add(M);
    return const Stream.empty();
  }

  @override
  Stream<M> get onAfterChanges {
    _eventBus.listenAfterChangesFailed.add(M);
    return const Stream.empty();
  }

  @override
  V evaluate<V>(Selector<M, V> select) {
    _eventBus.evaluationFailed.add(M);
    return null;
  }

  @override
  V evaluateUnary<V, X>(SelectorUnary<M, V, X> select, X x) {
    _eventBus.evaluationFailed.add(M);
    return null;
  }

  @override
  V evaluateBinary<V, X, Y>(SelectorBinary<M, V, X, Y> select, X x, Y y) {
    _eventBus.evaluationFailed.add(M);
    return null;
  }

  @override
  void assign<V>(Writer<A, V> write) {
    _eventBus.assignmentFailed.add(A);
  }

  @override
  void assignUnary<V, X>(WriterUnary<A, V, X> write, X x) {
    _eventBus.assignmentFailed.add(A);
  }

  @override
  void assignBinary<V, X, Y>(WriterBinary<A, V, X, Y> write, X x, Y y) {
    _eventBus.assignmentFailed.add(A);
  }
}
