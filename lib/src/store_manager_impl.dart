import 'interfaces_public.dart';
import 'state_repository.dart';
import 'types_public.dart';
import 'types_utils.dart';

class StoreManagerImpl implements StoreManager {
  const StoreManagerImpl(this._repository);

  final StateRepository _repository;

  @override
  void execute(Execute fn) {
    if (!_repository.isTeardowned) fn(this);
  }

  @override
  void executeUnary<X>(ExecuteUnary<X> fn, X x) {
    if (!_repository.isTeardowned) fn(this, x);
  }

  @override
  void executeBinary<X, Y>(ExecuteBinary<X, Y> fn, X x, Y y) {
    if (!_repository.isTeardowned) fn(this, x, y);
  }

  @override
  V read<M, V>(Read<M, V> fn) {
    return fn.isGeneric && !_repository.hasModel<M>()
        ? fn(_getReader())
        : _repository.getByModel<M>().read(fn);
  }

  @override
  V readUnary<M, V, X>(ReadUnary<M, V, X> fn, X x) {
    return fn.isGeneric && !_repository.hasModel<M>()
        ? fn(_getReader(), x)
        : _repository.getByModel<M>().readUnary(fn, x);
  }

  @override
  V readBinary<M, V, X, Y>(ReadBinary<M, V, X, Y> fn, X x, Y y) {
    return fn.isGeneric && !_repository.hasModel<M>()
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
