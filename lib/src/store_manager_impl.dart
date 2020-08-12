import 'interfaces.dart';
import 'store_repository.dart';
import 'types.dart';

class StoreManagerImpl implements StoreManager {
  const StoreManagerImpl(this._repository);

  final StoreRepository _repository;

  @override
  V read<M, V>(Read<M, V> fn) => fn(_getModel());

  @override
  V readUnary<M, V, X>(ReadUnary<M, V, X> fn, X x) => fn(_getModel(), x);

  @override
  V readBinary<M, V, X, Y>(ReadBinary<M, V, X, Y> fn, X x, Y y) =>
      fn(_getModel(), x, y);

  @override
  void apply<A>(Apply<A> fn) {
    fn(_getAccumulator());
  }

  @override
  void applyUnary<A, X>(ApplyUnary<A, X> fn, X x) {
    fn(_getAccumulator(), x);
  }

  @override
  void applyBinary<A, X, Y>(ApplyBinary<A, X, Y> fn, X x, Y y) {
    fn(_getAccumulator(), x, y);
  }

  M _getModel<M>() =>
      M == StoreReader ? _getCastedThis() : _repository.getModel();

  A _getAccumulator<A>() =>
      A == StoreManager || A == StoreExecutor || A == StoreReader
          ? _getCastedThis()
          : _repository.getAccumulator();

  T _getCastedThis<T>() => this as T; // ignore: avoid_as
}
