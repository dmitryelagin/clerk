import 'action.dart';
import 'interfaces_private.dart';
import 'interfaces_public.dart';
import 'interfaces_utils.dart';
import 'state_manager.dart';
import 'state_repository.dart';
import 'types_public.dart';
import 'types_utils.dart';

class StoreManagerImpl implements StoreManager {
  StoreManagerImpl(this._repository, this._eventBus);

  final StateRepository _repository;
  final StoreActionEventBusController _eventBus;

  @override
  void execute(Action action) {
    if (action == null || _repository.isEmpty) return;
    _eventBus.beforeAction.add(action);
    action.execute(this);
    _eventBus.afterAction.add(action);
  }

  @override
  V evaluate<M, V>(Selector<M, V> select) {
    final state = _repository.getByModel<M>();
    if (state != null) return state.evaluate(select);
    if (select.isGeneric) return select(castEvaluator());
    _eventBus.evaluationFailed.add(M);
    return null;
  }

  @override
  V evaluateUnary<M, V, X>(SelectorUnary<M, V, X> select, X x) {
    final state = _repository.getByModel<M>();
    if (state != null) return state.evaluateUnary(select, x);
    if (select.isGeneric) return select(castEvaluator(), x);
    _eventBus.evaluationFailed.add(M);
    return null;
  }

  @override
  V evaluateBinary<M, V, X, Y>(SelectorBinary<M, V, X, Y> select, X x, Y y) {
    final state = _repository.getByModel<M>();
    if (state != null) return state.evaluateBinary(select, x, y);
    if (select.isGeneric) return select(castEvaluator(), x, y);
    _eventBus.evaluationFailed.add(M);
    return null;
  }

  @override
  void assign<A, V>(Writer<A, V> write) {
    _getStateForAssignment<A>()?.assign(write);
  }

  @override
  void assignUnary<A, V, X>(WriterUnary<A, V, X> write, X x) {
    _getStateForAssignment<A>()?.assignUnary(write, x);
  }

  @override
  void assignBinary<A, V, X, Y>(WriterBinary<A, V, X, Y> write, X x, Y y) {
    _getStateForAssignment<A>()?.assignBinary(write, x, y);
  }

  StateManager _getStateForAssignment<A>() {
    final state = _repository.getByAccumulator<A>();
    if (state != null) return state;
    _eventBus.assignmentFailed.add(A);
    return null;
  }
}
