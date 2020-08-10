import 'interfaces.dart';
import 'store_repository.dart';
import 'types.dart';

class StoreManagerImpl implements StoreManager {
  const StoreManagerImpl(this._repository);

  final StoreRepository _repository;

  @override
  V read<M, V>(Read<M, V> fn) {
    return _isReaderApplicable<M>()
        ? fn(_getCastedThis())
        : _repository.getByModel<M>().read(fn);
  }

  @override
  V readUnary<M, V, X>(ReadUnary<M, V, X> fn, X x) {
    return _isReaderApplicable<M>()
        ? fn(_getCastedThis(), x)
        : _repository.getByModel<M>().readUnary(fn, x);
  }

  @override
  V readBinary<M, V, X, Y>(ReadBinary<M, V, X, Y> fn, X x, Y y) {
    return _isReaderApplicable<M>()
        ? fn(_getCastedThis(), x, y)
        : _repository.getByModel<M>().readBinary(fn, x, y);
  }

  @override
  void apply<A>(Apply<A> fn) {
    if (_isManagerApplicable<A>()) {
      fn(_getCastedThis());
    } else {
      _repository.getByAccumulator<A>().apply(fn);
    }
  }

  @override
  void applyUnary<A, X>(ApplyUnary<A, X> fn, X x) {
    if (_isManagerApplicable<A>()) {
      fn(_getCastedThis(), x);
    } else {
      _repository.getByAccumulator<A>().applyUnary(fn, x);
    }
  }

  @override
  void applyBinary<A, X, Y>(ApplyBinary<A, X, Y> fn, X x, Y y) {
    if (_isManagerApplicable<A>()) {
      fn(_getCastedThis(), x, y);
    } else {
      _repository.getByAccumulator<A>().applyBinary(fn, x, y);
    }
  }

  bool _isReaderApplicable<T>() => T == StoreReader;

  bool _isManagerApplicable<T>() =>
      T == StoreManager || T == StoreExecutor || T == StoreReader;

  T _getCastedThis<T>() => this as T; // ignore: avoid_as
}
