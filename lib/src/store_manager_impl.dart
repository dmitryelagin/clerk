import 'action.dart';
import 'interfaces_private.dart';
import 'interfaces_public.dart';
import 'interfaces_utils.dart';
import 'state_repository.dart';
import 'types_public.dart';
import 'types_utils.dart';

class StoreManagerImpl implements StoreManager {
  StoreManagerImpl(this._eventBus, this._repository);

  final StoreActionEventBusController _eventBus;
  final StateRepository _repository;

  @override
  void execute(Action action) {
    if (action == null || _repository.isEmpty) return;
    _eventBus.beforeAction.add(action);
    action.execute(this);
    _eventBus.afterAction.add(action);
  }

  @override
  V evaluate<M, V>(Selector<M, V> select) =>
      select.isGeneric && !_repository.has<M>()
          ? select(castEvaluator())
          : _repository.getByModel<M>().evaluate(select);

  @override
  V evaluateUnary<M, V, X>(SelectorUnary<M, V, X> select, X x) =>
      select.isGeneric && !_repository.has<M>()
          ? select(castEvaluator(), x)
          : _repository.getByModel<M>().evaluateUnary(select, x);

  @override
  V evaluateBinary<M, V, X, Y>(SelectorBinary<M, V, X, Y> select, X x, Y y) =>
      select.isGeneric && !_repository.has<M>()
          ? select(castEvaluator(), x, y)
          : _repository.getByModel<M>().evaluateBinary(select, x, y);

  @override
  void assign<A, V>(Writer<A, V> write) {
    _repository.getByAccumulator<A>().assign(write);
  }

  @override
  void assignUnary<A, V, X>(WriterUnary<A, V, X> write, X x) {
    _repository.getByAccumulator<A>().assignUnary(write, x);
  }

  @override
  void assignBinary<A, V, X, Y>(WriterBinary<A, V, X, Y> write, X x, Y y) {
    _repository.getByAccumulator<A>().assignBinary(write, x, y);
  }
}
