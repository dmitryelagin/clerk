import 'interfaces.dart';
import 'store_repository.dart';
import 'types.dart';
import 'types_utils.dart';

class StoreManagerImpl implements StoreManager {
  const StoreManagerImpl(this._repository);

  final StoreRepository _repository;

  @override
  V read<M, V>(Read<M, V> fn) {
    return fn.isGeneric && !_repository.hasModel<M>()
        ? fn(_getTypedThis())
        : _repository.getByModel<M>().read(fn);
  }

  @override
  V readUnary<M, V, X>(ReadUnary<M, V, X> fn, X x) {
    return fn.isGeneric && !_repository.hasModel<M>()
        ? fn(_getTypedThis(), x)
        : _repository.getByModel<M>().readUnary(fn, x);
  }

  @override
  V readBinary<M, V, X, Y>(ReadBinary<M, V, X, Y> fn, X x, Y y) {
    return fn.isGeneric && !_repository.hasModel<M>()
        ? fn(_getTypedThis(), x, y)
        : _repository.getByModel<M>().readBinary(fn, x, y);
  }

  @override
  void apply<A>(Apply<A> fn) {
    if (fn.isExecution && !_repository.hasAccumulator<A>()) {
      fn(_getTypedThis());
    } else {
      _repository.getByAccumulator<A>().apply(fn);
    }
  }

  @override
  void applyUnary<A, X>(ApplyUnary<A, X> fn, X x) {
    if (fn.isExecution && !_repository.hasAccumulator<A>()) {
      fn(_getTypedThis(), x);
    } else {
      _repository.getByAccumulator<A>().applyUnary(fn, x);
    }
  }

  @override
  void applyBinary<A, X, Y>(ApplyBinary<A, X, Y> fn, X x, Y y) {
    if (fn.isExecution && !_repository.hasAccumulator<A>()) {
      fn(_getTypedThis(), x, y);
    } else {
      _repository.getByAccumulator<A>().applyBinary(fn, x, y);
    }
  }

  T _getTypedThis<T>() => this as T; // ignore: avoid_as
}
