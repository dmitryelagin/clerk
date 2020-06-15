import 'action.dart';
import 'interfaces_private.dart';
import 'interfaces_public.dart';
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
  V read<M, V>(Read<M, V> fn) {
    return fn.isGeneric && !_repository.has<M>()
        ? fn(_getReader())
        : _repository.getByModel<M>().read(fn);
  }

  @override
  V readUnary<M, V, X>(ReadUnary<M, V, X> fn, X x) {
    return fn.isGeneric && !_repository.has<M>()
        ? fn(_getReader(), x)
        : _repository.getByModel<M>().readUnary(fn, x);
  }

  @override
  V readBinary<M, V, X, Y>(ReadBinary<M, V, X, Y> fn, X x, Y y) {
    return fn.isGeneric && !_repository.has<M>()
        ? fn(_getReader(), x, y)
        : _repository.getByModel<M>().readBinary(fn, x, y);
  }

  @override
  void write<A, V>(Write<A, V> fn) {
    _repository.getByAccumulator<A>().write(fn);
  }

  @override
  void writeUnary<A, V, X>(WriteUnary<A, V, X> fn, X x) {
    _repository.getByAccumulator<A>().writeUnary(fn, x);
  }

  @override
  void writeBinary<A, V, X, Y>(WriteBinary<A, V, X, Y> fn, X x, Y y) {
    _repository.getByAccumulator<A>().writeBinary(fn, x, y);
  }

  T _getReader<T>() => this as T; // ignore: avoid_as
}
